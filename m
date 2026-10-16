Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DA54704D;
	Fri, 16 Oct 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135103; cv=none; b=dfibJCd8PtF/1wQG6QYj1wW/ZKP9hgc2TUAgVdrJBx3eStmGNV0mSz3xoKaEsXicZSo7ccmBErWmDMY8HreQjns+4r5siFdYpLMdQBX1QHjrLNXxeyuIS5hWnLFqbO5ziHThRvicysM2Ez5cxKTfuKtbWKgD2s9Rq2IanSgf5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135103; c=relaxed/simple;
	bh=fn7t73BAlfIek4KFsTUt+UaONcMB7s/WdoiD3ZzK6rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6Okxia+E/OO8/ZhXZ2Q/hgK/5IQQzKqG9iW2oxMf3sDahBn26nD5AISD99r1qoAwHgUBwQiyuFFaCtu7WZPaK+vtFepuhunpDt4XAiIT4mzNFsiCjAHfCkR4+xUTGJJqKFyZKQHPw2vA+JByGgrlqa75PkrH1KleEkyKKs6Ngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CEaZdEGv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CEaZdEGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=re
	6vE4SzLfkyFSZUF01MKloypKa/WyfOPHKxbom6UXk=; b=CEaZdEGvQpwct1UQEU
	/kdYWvT4Go2ttSgdydGAy9U6QC8zeDzRC6tKvcki6/W6N2Hb30xlipdGcVpRb/pe
	Ra1NmDTk3aHBqEwEyiui4RStRVsmRAm6mtAQgQ+FgIvg7Wx5RCVX8wctNdIWfJMb
	a3/LV+TTymOSxN4Az0FMxfhek=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3jyaFz9FqVrDQAQ--.5020S3;
	Fri, 16 Oct 2026 15:17:33 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Yuan Chen <chenyuan@kylinos.cn>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Print map_extra in map show
Date: Fri, 16 Oct 2026 15:16:58 +0800
Message-ID: <20261016071700.280539-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016071700.280539-1-chenyuan_fl@163.com>
References: <20261016071700.280539-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jyaFz9FqVrDQAQ--.5020S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDXr1UZrWkKr4xWw4kZwb_yoW8Aw1fpa
	9xGFyrGr4UXr15uw4qya1rZFW5Xws7Gry3GFnxG3yUZF97Wwn2qrWYyFyI9w13WF1fJan8
	Aa9IqF95C3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo-e5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5Q0m42rRz41TggAA3F

From: Yuan Chen <chenyuan@kylinos.cn>

bpf_map_info::map_extra carries per-map-type creation attributes
(hash function count for bloom filter, VMA start for arena). The
kernel prints it in fdinfo, but bpftool does not. Print the raw
value in plain and JSON output when non-zero, without interpreting
it per map type, like map_flags. The attribute is already overloaded
per map type, and bpftool must not grow per-type knowledge of it.

Example (bloom filter with 7 hash functions):

    117665: bloom_filter  name featu_bloom  flags 0x0
            key 0B  value 8B  max_entries 128  map_extra 0x7  memlock 520B
            pids fixture(3543054)

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a1..62e36c7934ff 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -483,6 +483,8 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 	jsonw_uint_field(json_wtr, "bytes_key", info->key_size);
 	jsonw_uint_field(json_wtr, "bytes_value", info->value_size);
 	jsonw_uint_field(json_wtr, "max_entries", info->max_entries);
+	if (info->map_extra)
+		jsonw_lluint_field(json_wtr, "map_extra", info->map_extra);
 
 	if (memlock)
 		jsonw_int_field(json_wtr, "bytes_memlock", atoll(memlock));
@@ -570,6 +572,8 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 	show_map_header_plain(info);
 	printf("\tkey %uB  value %uB  max_entries %u",
 	       info->key_size, info->value_size, info->max_entries);
+	if (info->map_extra)
+		printf("  map_extra %#llx", (unsigned long long)info->map_extra);
 
 	if (memlock)
 		printf("  memlock %sB", memlock);
-- 
2.54.0

