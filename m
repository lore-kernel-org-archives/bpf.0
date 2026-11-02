Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638072;
	b=AQ3Dm5WecHTGKZrVS6kyTP8mFqkLo1wKOQ9UTIK/tY7GRglLu2Gj2rVx7+y/1pzSgNi9
	 HxN4YSPv2JOA82x1Tk0jAjuEUyGC5o3Oi1Tku+a4JNMxFiLsal05v9mbva3O1RVN9SQdU
	 9OZI/NCnoFB5IEBobeVsVSlV6bB3u8Ojt3s6OaDc3xxFWvYQf00SoaHTEWqxIseE98P6+
	 eAQnJjQ/Mgz7wrHfNLZmNvjTunaJ6lKAdxSgi7UQc3JGLp+0wRqXlbSyHmqt+eUnx5jm2
	 DTy+RMCpsqlLBRKOfzkAmaaeNRH4jUAy5m0AImWJ9WvqXbEA+PQPgpWhZ9RpJsi4vyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5IJ6w5rzOzJkvt+m6YkcBjQhleW0i7KCr9FFPDFtnPQ=;
	b=W4dqxs2Hd8D0OJk6rBAa2Voutb57LNtSmQlJ6rF1B7EFY7cD3NfM/nHMTmgMxjLKLEXN
	 IHvSMa25dK5++EsCb+x8MZuKm1GiejPpZY0LWGMX9/4LnQIDUEdveqJkGiQWf69BZgtm9
	 o8uI8E2mYcH94tzYX42B8ZVzJPvDaIZkSWZD+0J/kSgc8OBvSXFfdIBqJIZs1nGlt8nQU
	 0tSLb62JrVFsBDlM1ydUnR6vZHlCif89AV5q5flHHPhYxLO3OMFZATbvXQs5mboR/mTwO
	 fSQmfB8ul8NH8St7UXf3IPOlZx2DaS2dA6em5OJme8MsEbEq84qS5/5vT7NKjL/xjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X7GXGES;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E02606B0EF
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E02606B0EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X7GXGES
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1941245a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638071; x=1794242871; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5IJ6w5rzOzJkvt+m6YkcBjQhleW0i7KCr9FFPDFtnPQ=;
        b=0X7GXGESAJ2uFz7FhtF7YtfgwMCd9xcAzDFSEIkxYC6Rf7EQK61R5LCWBFAB+FBnAm
         KP+0obwWdmeiZNB/rfFHsAkDDVOThR2AC+4Sp+3DhmLoN84Hht0utb/RSLJQ+7f+Cw/M
         ipEkyzlVVKQoNM8+0wN599N7ltz2F+lZ5J+NTpV2VVlFzv1nbZyifYpEBf69rsWxyL3M
         EHHYPFKfK8jIhNmsUvYEc5Cw72Nt7yNbP3lbMOrNMInBIpG2Jg4GQfZDR1ZDxvAxP+YZ
         8dkN3DlsDtMhdtLe03xaFA1y6SNucdFRtUgBLL43AqAw9jpqqP3ZpxfpChur63jFo2T2
         JVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638071; x=1794242871;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5IJ6w5rzOzJkvt+m6YkcBjQhleW0i7KCr9FFPDFtnPQ=;
        b=pXVSwg8dUpQG6nhhi/utdekFYZyXCAX3q7giIDMNJ43ewsgo9T+ao0zOU+FjI3xIlh
         IsM0vJPOuzkHG9gJe0KwatljSJzXvzGoVK/BhKYQy81eMvy0FmH7mrb7AKiNGU15GndU
         2fPXVvBx4LYhPL0ecC57GXd9GAzeeL7pAFkvfNVbxccEufMJZ+tiW+aD8ODX2DTs6LFS
         mMsktXswyqiSjAgfPuvysSMlNQOggbNg1UHsVgIEUMCgWAjhewF2JwfmOsPfuXM1i1JC
         A4V6UT17Jz86GqzUh18SGpHXuTioGeBfPAPaysfPVKCnn3gCASin2IfjTKaXWLR8/G9b
         3p1w==
X-Forwarded-Encrypted: i=1; AKwUvBwBd5yr2vshWDU+oObvv1e7kQreqsS+Y95wMlyry8C12w0R/De2jBWR46ylViOi1HveIZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MaZ4WE4BSIEvzwvyev55XjYbT8EOQ3Ek4J/zPOH+6lrg3Ti5I
	v/wsU0GE8impPyH+hFQkw/vnbcmapI1abCOJxKThwXOBNjm7I0NnYldUNs89Aw==
X-Gm-Gg: AYBFou15yoQvrNG05aPGnVCMSrTREqd3KRKyw9YqigSVM8N818mDljDPM40ynK+eWcj
	EGUT4mK6oeqs2wOgCNzmUSCWrbGLcTCn0MwDPAMIFbmF9pLoB1PlqFJFOsnhVywj2+GmaIZU2Mx
	Kdp34si2XOT07OF2xyT1ml8y1Mj6IzU3CrmP3chpyTkfJLIOaSsQF1KbwKLuuXktvs7WpC/ab4M
	Akl3kvyvNNTzfd4CmSRNA6cpdR6JrtNmYbUEaWFILgmTjjreFMvmjzhV+QEKel9PsKzrK3fonhC
	a0c2HUvGwU3usnoFFc6W37kZHq/IFsNPOMD6bruR4c7BCBJTam6BjntYveGxmJy7x33WfVMF9mR
	oPPMcfrF6Zdl737bWW2dIExGFsOJ83uRFSIil4F8IKE2YNM/GU51wLbxQ5zk8VU1ZeAj91UyM5E
	p6Sq+K61nDIRzMAIbvjzj0qaC/1B5GribQP2HmLtRYLcifQ58AglbPLDD5gVQy5epeDnPwRk1Nf
	pPiVff/7kOFq49gDJIdPzCYDkhkuvEeQxnXXyAcn6WyAxypU557cS5EoI+mKKauZVysnQ3peL8S
	JN0PgU+1k+Q94J0v5jChtujYjYxrulF2i6ck4p/pQtI4x4mOSWBL3TmpbBQzjko/QxjUhiCrDJd
	5bOpMUnLRgrEiDbhLFGQjhlcVJglpG4JwJcLbYRjAI+ptTLCMVraivxc=
X-Received: by 2002:a17:90b:3909:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ae89536c23mr8235381a91.7.1793638070707;
        Mon, 02 Nov 2026 08:47:50 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm19496974a91.3.2026.11.02.08.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:47:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:47:48 +0000
Message-Id: <DMKVMPJUIHT1.T3WBE1MBIDA1@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <alan.maguire@oracle.com>
Subject: Re: [PATCH v2] libbpf: Fix ENODATA comparison and unbounded
 zero-scan in btf_dump
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gu Bin" <gubin@cmss.chinamobile.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
References: <20261102085122.916-1-gubin@cmss.chinamobile.com> <20261102131632.1124-1-gubin@cmss.chinamobile.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 05:16 AM Gu Bin <gubin@cmss.chinamobile.com> wrote:
> In btf_dump_type_data_check_zero(), the BTF_KIND_STRUCT/UNION branch
> compares the per-member result with ENODATA (no minus sign), unlike
> every other branch which uses -ENODATA.  The function returns

This part is already fixed in bpf-next. See
commit ab332ec8953d ("libbpf: Fix struct and union zero detection in BTF dumper").
Pls rebase. Drop this part from the subject and from the commit log.

[...]

> @@ -2533,6 +2533,12 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
> +			err = btf_dump_type_data_check_overflow(d, elem_type,
> @@ -2565,9 +2571,15 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
> +			err = btf_dump_type_data_check_overflow(d, mtype, m->type,

No need for two copies. Do the check once at the top of
btf_dump_type_data_check_zero(). Every member and every element goes
through it.
The only other read is *(char *)data in the array branch. The recursion
for element 0 gives the same answer, so that line can go.

Something like this (not even compile tested):

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ea9a34d..d842ae1 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2504,6 +2504,11 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 	     !d->typed_dump->is_array_char))
 		return 0;

+	/* members and elements get here without a check against data_end */
+	err = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
+	if (err < 0)
+		return err;
+
 	t = skip_mods_and_typedefs(d->btf, id, NULL);

 	switch (btf_kind(t)) {
@@ -2533,14 +2538,12 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 		 * non-zero because the string is terminated.
 		 */
 		for (i = 0; i < array->nelems; i++) {
-			if (i == 0 && ischar && *(char *)data == 0)
-				return -ENODATA;
 			err = btf_dump_type_data_check_zero(d, elem_type,
 							    elem_type_id,
 							    data +
 							    (i * elem_size),
 							    bits_offset, 0);
-			if (err != -ENODATA)
+			if (err != -ENODATA || ischar)
 				return err;
 		}
 		return -ENODATA;

Pls add a selftest as patch 2. TEST_BTF_DUMP_DATA_OVER() with an all-zero
union bpf_iter_link_info and sizeof() - 1 is enough.
bpf-next returns 16 for it today. It has to return -E2BIG.

Pls tag the respin as [PATCH bpf-next v3].

pw-bot: cr
