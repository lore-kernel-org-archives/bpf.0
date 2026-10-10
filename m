Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF21FE471;
	Sat, 10 Oct 2026 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618347; cv=none; b=r/Mzm4jSUEnGSTF3W26tpOvNpCNuBDQlxcbw7ZZJRTtksA9l/QivSVIHfwRyIfQYSoeCK8P+Q/pC4H1NLVE58kvEXrreliGSlHcbwkKUakaw2VGlOXAjpk8CiT1W1xsaeghoBMbPekUxSR3ei/nUHECNBYiVASjnitoaK54pBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618347; c=relaxed/simple;
	bh=T+Z00RH3HIxelQRmyMXv776EBhq38v2IrgliGcUP9iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGx3QM2hb9vTKFSUO5W+wabyBUKVbiJ71BvtWehwyfog05Ed7DbfgE9EuDFdBhKdLX9IAeFyB6l/VoOI1heU8uTW76Q1T6Tnzk6GRCHqQDf7IToCIXYbqbIVSJGWtsA6Fd7tRS8+GXlJ0ITwoST4UNSKtf15lchlt84YzADp34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ehd87S22; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ehd87S22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wa
	cfHBcFH1tmaxMAaJaDd5DCKfunSWSOW0nEYzna8Hw=; b=Ehd87S225WX9XrxSBY
	Bore4b0nP8kMZMMmd+lC8cxB9CXwHVuMzaoNgy3WD0uqwWxJY+0ygxMNSq4z7l8q
	+2sSWIQizYR67YL4GnFSkGMf/Xal598+s7lYGA3LsS8JZBrMvzvJx8orRr7gU2sb
	qFqUkYcVmzYPDLzDqd7f2O9i8=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXX+Tr7Mlq0R5VDw--.36602S2;
	Sat, 10 Oct 2026 15:44:44 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpftool: Fix out-of-bounds read in kprobe_multi link info dump
Date: Sat, 10 Oct 2026 15:44:35 +0800
Message-ID: <20261010074435.1415234-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXX+Tr7Mlq0R5VDw--.36602S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury7ZFW8GFyxKF45XFWrKrg_yoW8uFy3pa
	n8tw45KFs5XF15ur17Aa1rWFWYvFs7ZrWrCFy7Gw17Zrn8JFn0vFnrKFW0vF13urn5t3yU
	Arnxury3ZFWfZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QyDQWrJ7OzDTQAA3G

From: Yuan Chen <chenyuan@kylinos.cn>

show_kprobe_multi_{plain,json}() walk the sorted kallsyms array against
the sorted addr/cookie array with j as a cursor into the latter. The
loop terminating condition is checked after the cursor has already been
used to access the array:

    if (j++ == info->kprobe_multi.count)
            break;

After all count entries have been printed, j has been bumped to count,
but the loop keeps running and dereferences data[count] -- one element
past the end of the calloc(count, sizeof(*data)) allocation -- while
comparing every remaining kallsyms symbol. If the out-of-bounds value
happens to match a symbol address, a bogus entry with a garbage
addr/cookie pair is printed to boot.

Fix the off-by-one by advancing the cursor before the comparison, so the
loop terminates as soon as the last entry has been printed.

Verified with an ASAN build of bpftool against a live kprobe_multi link
of 3 symbols:

  before: ERROR: AddressSanitizer: heap-buffer-overflow READ of size 8
          at link.c:860 (show_kprobe_multi_plain) and link.c:352
          (show_kprobe_multi_json), 0 bytes after the 48-byte
          get_addr_cookie_array() allocation
  after:  clean output, no ASAN report

Fixes: edd7f49bb884 ("bpftool: Show kprobe_multi link info")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 088d1d206065..5cffa2d283b4 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -364,7 +364,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		}
 		jsonw_uint_field(json_wtr, "cookie", data[j].cookie);
 		jsonw_end_object(json_wtr);
-		if (j++ == info->kprobe_multi.count)
+		if (++j == info->kprobe_multi.count)
 			break;
 	}
 	jsonw_end_array(json_wtr);
@@ -867,7 +867,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 		else
 			printf("  ");
 
-		if (j++ == info->kprobe_multi.count)
+		if (++j == info->kprobe_multi.count)
 			break;
 	}
 error:
-- 
2.54.0

