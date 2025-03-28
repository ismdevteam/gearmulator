#include "filetype.h"

#include "baseLib/filesystem.h"

namespace pluginLib
{
	const FileType FileType::Syx("syx");
	const FileType FileType::Mid("mid");
	const FileType FileType::Empty({});

	bool FileType::operator==(const FileType& _other) const
	{
		return baseLib::filesystem::lowercase(m_type) == baseLib::filesystem::lowercase(_other.m_type);
	}

	bool FileType::operator!=(const FileType& _other) const
	{
		return !(*this == _other);
	}
}
