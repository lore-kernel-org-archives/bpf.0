Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE823DCD95
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033075; cv=none; b=aG820sxfE52IZKZK8yzcYsmxPOLQwTyn6LXQOO/LtGoRJBFhUfhhKRICQ5lJm0ttN7B2en/w3IUiTULsF0QmgyX/H7rR5Oz3gFy9CmKl/A6SgcqliprD7dSFBn2DJD4YnwO6h6NS+zp9RDuGNdGCAfA1sfhA0btqiYwl9P2XD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033075; c=relaxed/simple;
	bh=qaOUyW5IL2nDBOP/T8AQBstIKln/sI9NTa5siU1GJCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGInqKRpaH6LusDOC3eiGecq4Gd9LG9TrC/lNhfwKODq93rFjnL6xZ5b38qjqXcEVuU7zz8cPbyUq3iY7HPT+xpIgZBEmL93WxthazeVjyndkTQoiJ0SLotk00C+nTJ1ieXnYNFR4yIPxpMf9wWXRGXFS0zTfuWnSr3cL+1FRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni7CtcKE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni7CtcKE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-851cbd64814so3612597b3a.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789033070; x=1789637870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2muRR/L1aYGswy/W25KVCyqi25VlI9ETG1ynQSgu8DA=;
        b=ni7CtcKEWyVUiJKGc5ztdiQDi92AVBGIXcyGnlxL8AslrzFqCyKcXiyDMyf3qx/435
         Yoq0L69qfJnw11i5IePDRoTwiXDV1NKeLCRaKsLe14Q07V7EKc51m473mXfvBtuQRbVD
         ATbcq/bYx61UmZCr0DYTZu2meMGmj/R/Ge8X1jp0z9lYktdWEG8xW/INPZa2k/JTJCv5
         eRMvfBWxDC1os1IyblVBAVUlcD6S3IT5sAGH09pp3n7LXuQQDoV4tvkexRseO8ihJ3iq
         ehtxZB+/jjiSEMxX+eKkDq7Dc9QnYrwKAD4any0g8qAVCa6HT68r5MoIHpEySswmu1hd
         IfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033070; x=1789637870;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2muRR/L1aYGswy/W25KVCyqi25VlI9ETG1ynQSgu8DA=;
        b=p4k8ZvyiBRfAjdI5EX0an1DnqvtbmuwYvRr+uoG2laed6vjnACt1Ru3rf3aJzU1X6s
         3sAY/mgeCkmSNL/34rEFaPtwTHk6s+kfyXuzzQCcaaIh2Rog6eMreEtuY0sSf0DNlpkw
         /OCfi9gCqMloPXkx8ObhuhXlubr3HD/KlfTTPHrMhNfiequmFkPbQ+IhjLN2IlX2ekuF
         SdOFhrHy1IP4Ot9jd0/2vPB5jtPs/43WYpLlLc55lER+My0MixI+l+v0CBkKZIjrMuJZ
         I5JUurPi1SDjDqKiFcvPX/wV6FwbOy42ulT2T/4LpdSXcZ4Vymr8CyrRM95R9t3/C3tB
         OhXg==
X-Forwarded-Encrypted: i=1; AKwUvBxgq7yhSd4NhzEhh6rTDvKFSpkEcUuTNwBdCxgjmsb0AhxdXm8KmAAhCU8uj16LvkjIedQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mFL2ImvxLrh9yUCk7njrfHPNcSJCxrk6tJcNtdYkyyy4bv7XcP
	7RiNVHVO6DrSS+0mGBDLGJvld6BY2TpbTmzd4nq1OgLlRLGMKBDrq+rC
X-Gm-Gg: AYBFou1ClYMuZ3xejd/eTJqLBIUDISehlS3F2iEyrqlxnJcHy89nhimggnXF0GEzQEI
	J//RhoDeN432qmzNmjjYMGcmA1Y+SS1HT0CjiJcsnQQOPph8zJ8X82IQvsGEscw5uNhW3zgZka+
	x19aHknXguQlQWqTT53k8ZcHok58YawGkRg6b/NL7PuTeKnI/fn4hW5S0bMIbmpACcZX8f69FqL
	Ir81sCo6ySz9p6SSAYXOt6MqaEUGbrdH3HL4RAFvE9ESKdAaG3kcQoLNaG3SB2uz5V1hXzVTdIV
	IzsBuqyTEGRrQLgjJwQO62cycY+hUNT+eCl9yFF6OsDeRnT/rqOzLB8iGSMk3Vhp59gdyevpO8X
	u6P8l0WdoPA5ikiBmhUpZRzr9KV9tSchvXGhQiWdED2cSQlVlsCcvA3qVfQJDjDcAkhQzieYWXo
	gqVTGIVCbxLZik3IZMtWKTwKQqDJI1+jx1OyGD92tusTIm4NLaPW1mOKN3enO2HkCCdKYsIQptY
	8CCJXI/9mUDC7SAKXlmuL5/QJA=
X-Received: by 2002:a05:6a20:734c:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3da39eacfd3mr58477519637.3.1789033070142;
        Thu, 10 Sep 2026 02:37:50 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455406f14sm8289391a12.5.2026.09.10.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:37:49 -0700 (PDT)
Message-ID: <98c9c5838b50871b3a138d2104450774268644b3.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF
 types into split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Thu, 10 Sep 2026 02:37:46 -0700
In-Reply-To: <20260901165757.801449-4-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
	 <20260901165757.801449-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
> Extend btf__permute() with an optional transfer mode.=C2=A0 Type-map entr=
ies
> marked with BTF_PERMUTE_ID_TRANSFER are removed from the input BTF and
> copied into a newly-created split BTF returned through
> btf_permute_opts.transfer_btf.
>=20
> While moving types, remap type IDs for both retained and transferred
> types, preserving split-BTF references to the parent BTF where needed.
>=20
> String handling has to be done carefully as we do not want to have
> strings that only exist in the split BTF to impose a cost on the base.
> Copy referenced strings locally first, compact the parent string table
> after the moved types are gone, rebase split-string offsets, and compact
> the split string table.=C2=A0 This leaves strings exclusively needed by m=
oved
> types in the split BTF while retaining shared strings in the parent.
> This will be important later for function names of inline-only functions;
> these should not take up space in base BTF but should have strings in
> inline BTF only.
>=20
> This all provides the support needed to place inline-only BTF
> in a separate BTF section, which resolve_btfids will use later.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Assisted-by: Codex (GPT-5)
> ---

Hi Alan,

What do you think about an alternative approach to permute and
resolve_btfids changes described below?

Instead of specifying a permute mapping can just rebuild two BTFs from
scratch: base BTF w/o LOC types and .BTF.inline BTF with LOC types only.
This would give strings dedup / compaction for free and would not
require further changes in libbpf.

Concretely, commit [1] (branch [2]) uses the following steps:
- Traverse all types reachable from LOC_PARAM, LOC_PROTO, LOCSEC
  entries and mark them as having LOC color.
- Traverse all types reachable from the remaining types
  and mark them as having MAIN or SHARED colors.
- Create a new base BTF object and copy all MAIN/SHARED types there.
- Create a new .BTF.inline object with base set to the new base BTF
  object, and copy all LOC types there.

This seem to be on par with your current branch with regards to
speed / memory usage:

=E2=94=82 Version                 =E2=94=82 Elapsed, mean =C2=B1 SEM =E2=94=
=82 Peak RSS, mean =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82 Original permute        =E2=94=82 338.8 =C2=B1 8.1 ms      =E2=94=
=82 71.20 MiB      =E2=94=82
=E2=94=82 Proposed                =E2=94=82 284.1 =C2=B1 10.2 ms     =E2=94=
=82 70.10 MiB      =E2=94=82

But seems a tad simpler in terms of implementation (~ -250 lines of code).

I also changed how LOC-only FUNC objects are identified, by using a
generic type graph traversal utility function (btf_mark_reachable()).
This is a bit less code and opens a possibility to move some more
types to .BTF.inline:

=E2=94=82 Section     =E2=94=82 Before (bytes) =E2=94=82 After          =E2=
=94=82 Change   =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=A4
=E2=94=82 .BTF        =E2=94=82 5,207,078      =E2=94=82 5,047,510      =E2=
=94=82 =E2=88=92159,568 =E2=94=82
=E2=94=82 .BTF.inline =E2=94=82 9,867,471      =E2=94=82 10,027,039     =E2=
=94=82 +159,568 =E2=94=82

This is the same change, but when allowed to move regular types from
base to .BTF.inline, if those types are not used by base.

[1] https://github.com/eddyz87/bpf/commit/abe515962632ad51f8aa50e44354b88f8=
0bbd606
[2] https://github.com/eddyz87/bpf/tree/resolve-btf-ids-btf-inline
    (tests commit is 100% slop, please ignore it).

Thanks,
Eduard

...
