Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609308;
	b=UuJVcbU0etNR7MPvhqnWsejM+mcY0skZblD98etIU4PMnbeFi+P1dUT08RXwFhE+GaES
	 dXgRd5gisS4ktq/EO/ah81kdegOOpKlod2Kx9KXIxkKVek8qNzFJSpHs7vWhH48n8Xho5
	 0WLOaZNM1YAZJTiqLHmshIetAgtG2tITMDLWiwcZRolk26BXJaCPjIgmPH6g4p+lNalz+
	 A1tsgwvxdRPq6tORMSqTEpeaMrFOkDoofAAhk7iO+Ob1ut3MDrhV2gQgq+SAMnxbUEn1u
	 Zr/3ZuIs1qepRLJo8HR6rwaUyUYZf0QzTYxbFxS/9o7DyyMAe6eqanRzOoNiQ1kM9vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0hvWQVj0nsGSKlzOns7G+ymeg0cenh8W4XpJvdH6lPY=;
	b=JatNl7CbtwpBwszCN7zizyzzt6gSq90ldR3TkmQE1Y5oa/fMv2IZKbxbaJttaVdZMHwj
	 sEXZ1xhi3v0zUcgMut9J3Cw+nnAar5SHRa064Z1FbI/BI+S0c7LhpO5xem2obg7myeoAQ
	 bxEmGVz3H/Qlv3hY142sRueCdT68ChRAq/QXjvbVYeJBHnIkNpwzmwzvFdYezKCmvsEKQ
	 runNtL4gvxuCG83VSO2oIY97WcYSlulLc4qJT02giwBVSK4xrWsQVFEJy0lU1Tu0n81pn
	 IRWkR9EoZVxgjkS7d77UVW42/LxdJtWeJjEWj+gBz3g5M8ELEEMvA4N+bpest/5bZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="X3dA/KZQ";
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F2606A883
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 671F2606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3dA/KZQ
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1521c45a248so1055795c88.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794609306; x=1795214106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0hvWQVj0nsGSKlzOns7G+ymeg0cenh8W4XpJvdH6lPY=;
        b=X3dA/KZQNcNBuGauOycccpriWdEWOwWQrH/qnEHKx96CzctrISCN02mgbMS4Ensak6
         u05zcItt/ifqRYISa+yOKWvn1JDDqur+BP6PGwuS2wplACDKTABC9moZ3Qfs9Do3jFDo
         H61qHNcoaqcssq2t73QP/KpW40BD4URfDWcbxPi7Li62+O3QMiCvQ2xAvrZlMiV1tW47
         yHd62vwkDAiwXMBUGcTL7hrx8KZpBv3EfkeW3cTznh3qxAnx0GHtGbCfPSwLe/7NwH9f
         cE0J0rREW9D/tVg1MYL8ZJ0DkMO3BCYMytV3M4qkwD8cuJgyVC5KTSC5ao0E61wpUqOh
         L2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609306; x=1795214106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0hvWQVj0nsGSKlzOns7G+ymeg0cenh8W4XpJvdH6lPY=;
        b=eMwUgSeEXrMSrIvv7GHSP34YOl+B/U3SWdDqvDFzBUXeijT/VKSM6IRHkGTbTlVQum
         He5ltEoEnE7L99Db4628uuTy0eWV2+VpObRKk7Qja8GRtZfNSe1KWnartxt+iB1sn4jB
         Asw9WU7Yq53iJU4cDRJtc3+nSiKDuVwEN/k4ZuvCySTw3QEcVhEQ9/nypft1KviqiKhN
         k/a52yLlI3OVha3JDdE+2dS1hC7hTDEesnD88OhyLENuLkHfa1aCtNIsnlAV9BW9Fvnh
         DtS3KnwAE1ra+0evjac7fYkgfJS42dEas4bBaSnrBGorsjgMTiW0M7E/V6XDypeaHy0G
         Gm0Q==
X-Forwarded-Encrypted: i=1; AL+hErGGUVdtkREo65pKFHuYSggQ0qKnWL42bG3ZW8DIKKcizbSaayx9NuWFxzuzkfzfpnYZFcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z93Qsmm4IfrhhdSPP4069gHF73Qyfgz9QcRsmjwWSTYBEIIyySF
	hBDLtlwmekoqdVpJZTIkDzIQDGqMLa/22uRuiXaI0na/53sad2GJVzJ5
X-Gm-Gg: AYBFou39WJGaG4ZVyPhE+OPASXMFVIhDLe0JvOtJWtW9RkdbdlnsnKqjjmQ1ZZOWL5H
	WDjcBuACmEHxsuJJTJod6Mrahp0gPDtzkJWFnRK8hRswfairhxPEJ1dH3tZnkpLIKqg0Wp2hBF0
	JxvF22b3svVTk9bLlnp6UrXUhItcEgCnjiLN0TZHAa4u/IuM4TBUpQzXS85Ga/sCSghwM01YJcB
	zxC7eICKsjRHw2IUVw7sCyev6ua6RA4Bn92n4px0hNU+UyPDzDNlCpspAmeuUm42TVqY3CcxdiY
	df1fhqKojM5pSBYzF7xwqWo9jaRxxVgWXRS9+jaLm/7S77tezTVilxxxMR6XmY8zbQ+WA24Qf/C
	ZzcVdTpGAW9u2G7EjiOvpoRZ+QdnPjCVCn4xivIEW5bs5H2Jd4nDPZf7CQVI2A1CtGVuwBvhiiH
	4Wr7FoBl8KGyJxFJa2X/cl9BSJgTaG4LKFXtymiTO1ZxT1kAecA4ebNNVF2snEhs5kE2ckTtHPd
	TnWz85kLtWYSDpWQAiD4mNNpW5+orxK28hWQdakEuWZ3mcl3BFok2X6K+Rx7oAZpWavsiovoQND
	ULWFtJFO4QT0nql8aBRlBDytyzhVVppZl8pTGe7yjcIC7NP2a3pYU5uks2gLo/JzYg624Lpguez
	59Mv2H5kOuijLRsBxNfwAAjFeRWp2rE+3kLByBg==
X-Received: by 2002:a05:701b:2706:b0:196:e254:db24 with SMTP id a92af1059eb24-1b50312f0abmr3427329c88.21.1794609306455;
        Fri, 13 Nov 2026 14:35:06 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm12003501c88.5.2026.11.13.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:35:06 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: andrii@kernel.org,
	bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	alan.maguire@oracle.com,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next] libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()
Date: Fri, 13 Nov 2026 22:34:49 +0000
Message-ID: <20261113223449.97604-1-dennylin0707@gmail.com>
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

btf_dump_get_enum_value() reads unaligned enum values through
btf_dump_get_bitfield_value() with a zero bit size. That path
zero-extends the value instead of using the signed loads that are used
for aligned data, so a negative value of a signed enum loses its
enumerator name when the data is unaligned.

Fix this by copying unaligned enum data into an aligned buffer, after
checking that the whole value is within the data, and reading it with
the same loads as aligned data.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bbe86928b3ec..30fe3bb48df6 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2329,16 +2329,13 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
 				   __s64 *value)
 {
 	bool is_signed = btf_kflag(t);
+	char buf[8] __attribute__((aligned(8)));
 
-	if (!ptr_is_aligned(d->btf, id, data)) {
-		__u64 val;
-		int err;
-
-		err = btf_dump_get_bitfield_value(d, t, data, 0, 0, &val);
-		if (err)
-			return err;
-		*value = (__s64)val;
-		return 0;
+	if (t->size <= sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {
+		if (data + t->size > d->typed_dump->data_end)
+			return -E2BIG;
+		memcpy(buf, data, t->size);
+		data = buf;
 	}
 
 	switch (t->size) {

base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
-- 
2.43.0

