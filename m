Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217657;
	b=j99EPB9LZVmOYLKwaY66Fe8bqwPc6tB7JwKaJ7ywRldF49E5g5pBghfE74tImtEzxy5y
	 WMPn2t7p3YqqXWVj7PIYUi6rC2Csrbh/8zwSnoYFS58dCH14E8uwQo8GR6GLNbTP86465
	 M5rSmHtWwgX5y5J4beRe+Aq+jcu2m1r6Re4sjVZ4MSdlM3pVrvL3eX2xiYeaiFZqx4Ir/
	 rywXVJc88Slqz+7TIIPYL10pYaFT9Fsx4HLr66U8WqsJlf60vD9tHMpnzcP77MQdhGhfk
	 sZMjhFLCIb52w+Kc43TN2o873/rNI3kuHoDz7eK5pWdapNTIx2PZA0XyDcB9W+bXSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oj7duHsLXoLKjIrO6qsttK1EfEJ3JQp/XqMmn+BIZS0=;
	b=4d30HDK0V5QR+Wj1X0vKEk8TU01hDdWiXXCe6tT3maHgefVhIYzGAwd6nypiHIYnsjC1
	 /zSTvlHCBRnL7kay3FxmCYmj7Sz3cUe4KzZwpJOsnAH2+Qb7rFygEYNZ0lsAC9U/9Nirc
	 lHA48wWKSKYfwoGt0MBkXl90Fo25LjfEhYA1frSCiJBJ5WeYBeyp6t8qKK79oW8/54kPJ
	 GRFLC3+eRmNlXS/ILM+ZGq/C+cvKd6Zf/mHqM94p0tXr65fJms54zEV02/ysPdYPbTZkl
	 Vjzp7tThLQiqk2SSDyiZ6hpcesxkr/ozD1iR2ZjWvSSo/qzFsBG6kO7wLWtxaFUBgyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WEyA8oeB;
	arc=none smtp.remote-ip=74.125.227.202
Received: from mail-pi2-f10.google.com (mail-pi2-f10.google.com [74.125.227.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36520606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 09:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36520606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WEyA8oeB
Received: by mail-pi2-f10.google.com with SMTP id 41be03b00d2f7-cd5f0803c1eso219314a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217655; x=1794822455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oj7duHsLXoLKjIrO6qsttK1EfEJ3JQp/XqMmn+BIZS0=;
        b=WEyA8oeBwraJitEAc5CJ6WrMU7AbG4sEJJXGQdBkl4Vw16vF5G/SxbLHYFJpJDqRVm
         md5+bZ0Wvx/SceaNwsxpXHv+k2CJaeqyK4SdkvJdUZVCH9pCyAohKMeZ/myxkwbpdh9H
         aSPEYnWOn8N0RGteNcLMEuuW0anaMYInQ6dzK+om/Z2vdlBIeInRwuwYHAUl6cnGyyth
         BMnUW2n+Ru9cRtb1QKzxT1tbMVzDsVgG8e2/4rvMds0hL+ZrvWygTPx+DmZ8Vv6vH4u5
         XMumU8T/HvoGV9ggUfDJ+OzbVYvg0t37/E18S/IpuqW9kUv7J8FUgGabEjT1Hffzyerh
         2SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217655; x=1794822455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj7duHsLXoLKjIrO6qsttK1EfEJ3JQp/XqMmn+BIZS0=;
        b=PpwZGk/ZVYvj26A2FBkzbz/J/h1Sf2JojGjKqVuU284d12ZS2z6kCa8SS0t1iu7rMF
         asilnOQJSRZUmU3pw+FYrZnGpvhVaIJFGg6e7NrOq6rsm8YXVBX1e1reY+VkV4AqOmBh
         s3WbCXyxxiXFvFBgfMuEY0dm5TX8xlR3F05KqQFlPKIko2YAaWj5etmosoD4IsfeKa5t
         COYRv84N3dvs56+Q7OCw0xH28fmgfplZpBy8v7oG/t7e98yj+d0bqsk69Kg0AdPfuU7o
         HP9mKltuF7qkFDIHqGZTeCvFCQWTEtDSTky0tmSptubgXfsXMQUrj61gcSGERq01VtW5
         qgow==
X-Gm-Message-State: APuU4Z/S0OFn6TntUk2W6Uq+VTL8W8iHtbTSOjsRHviT1mGF7abqLJf3
	tWYLtC6H42cuYIuz5FFZIHOM7YpjDe2bLWFaQ0autTkiG61mgKFHEOTuzYhuv0no8YBXxA==
X-Gm-Gg: AYBFou3UpKOGQmbloB3B0y/yGCmrfT2gdMGggfzCvBphVFjK0Tqgxaf7mpyOzEe86Hd
	N8YhCv+QexqbgJvUuKtLIZJv9IStvV+zfYEo4cZACZsSIuxwVgt+pSHtHxT7AuftUHM6DGIX+sC
	+NSzvnCFjTeVqUA70lJE0POmCIZvLJRDEdbr3HP3+KeVzzb3Sef7E/fCnVjg7b/w4lsRbteYhBl
	hdTHkXMNUzLhAdD2yO25O1ipopslBS7BzhKWW8JkMzJxL9ahu2JwXjIBKV7+zL8ywxS6i6eiw8D
	3G2k6Aj87Y27eP8LkPphpHcKiaLHGzdHWOxMiYL96ausIaR+qp+xNYdJ/vLS+CKxaXlSqDzyfV7
	v9lbo3nQZS/DwlLba+nRPuon3QN0q/GfxRyID+BCBy2U+QFoZ4HlQmzsW6oyfw6uPq59maGXsgU
	945iwO/5rPl5fcv1S3A0k0yexRiZUHQwTLbjnwQcEikwpFFXFyA4pblAbFg0oN15C2DIYgwrMAd
	bvoSjWu8/9qXyi+E0lKFOk4Of+I/Ihwe0JVeqU080y5GGzzB9GQDljS2WJM0wStZH8MotjznLY3
	DM2NWUyVz8St/wpN2qrMKjBtpW6qSkKPvvEn7nsyOY0/lto=
X-Received: by 2002:a05:6a20:6a1c:b0:3eb:3b69:77cd with SMTP id adf61e73a8af0-3eed407af92mr3157286637.71.1794217655420;
        Mon, 09 Nov 2026 01:47:35 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b649824124sm1110517b3a.32.2026.11.09.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:47:34 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v3] bpf: Check variable-offset accesses against special fields
Date: Mon,  9 Nov 2026 17:47:23 +0800
Message-ID: <20261109094723.14614-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_struct_access() rejects direct access to special fields (kptr,
...) of program allocated objects, but for a variable offset it only
checks the access at min_off.  This is enough for compiler generated
BTF where members don't overlap, but btf_struct_check_meta() allows
overlapping members in hand-written BTF:

  struct node {
          int arr[4];             /* offset 0, size 16 */
          struct foo __kptr *p;   /* offset 8 */
  };

A 4-byte store to arr[i] passes the check at offset 0 and overwrites
p at run time for i == 2 or 3; bpf_obj_free_fields() then frees the
corrupted pointer.

Check the offsets the register can really take, min_off + k * step.
No separate constant offset path is needed: reg->step is never 0
(___mark_reg_known() sets it to 1), so a constant offset is k == 0.

Verified with hand-written BTF: a variable-offset store to arr[i] is
now rejected with "direct access to kptr is disallowed", while a
store to arr[i].data with step == sizeof(elem) still loads.

Fixes: 89e72f81a455 ("bpf: Varying offset access support for PTR_TO_BTF_ID pointers")
Link: https://lore.kernel.org/bpf/20261108152941.7363-1-shlomojune6@gmail.com/
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8bf39098ba97a1..2265362d8342f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8094,7 +8094,12 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
-			if (off < offset + field->size && offset < off + size) {
+			/* An access at 'lo' or above ends after the start of the field. */
+			s64 lo = max(min_off, (s64)offset - size + 1);
+
+			/* Round up to min_off + k * step. The step is never 0. */
+			lo += imod(min_off - lo, reg->step);
+			if (lo <= max_off && lo < offset + field->size) {
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
-- 
2.43.0
