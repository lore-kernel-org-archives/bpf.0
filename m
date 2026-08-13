Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C6371889
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660391; cv=pass; b=JY0CFH0Z+23AMjf9mBrjMdqiFxPXIa2U7ykmJgnnAlTnWMAquMOIbZqDMmrju5Xvwb8YfPqq3utYIno5G5XbV5Z+twHT0zGMDcXGWSNAVspcZayhyuj3BQZ3m+leb7Gdl6P5yEAU5C96+/Y6hD1vnR5xovFBWmN6eBR7+WUN0jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660391; c=relaxed/simple;
	bh=FOIcLM0bxNwc2XeqBek8fVKkqkawxUbpIvQ7cUMtiTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDR4nyqQTWjBgh4c/mR3ZkaF0ZmS4YgBiptOnbmPcriH0GMLt4V1XIkdSY2Aod9c8BWtr3RjoOA/L+yL8fBA2SHTlfp0H9/uQEi9zx+zqeOrgkfrpTGiNmFu2fej9zkjUHk+U84vKLnqvKons4AKjqHTT3RdM3V9ne3yffJUfUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFkxe72Q; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFkxe72Q"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ced3386430so4893745ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786660389; cv=none;
        d=google.com; s=arc-20260327;
        b=NAJBqebzT5qR3sx5M/ycNLlB+LOm2ECf+NPCij2Zq58AMRin5iKTYDyMocHtM64BKx
         vbo6f5+O89Nlyp7C8lZ3A+JD6VV02AGgrbhD8VCeuiDuvs0lh2Sf+nZkVlj9LZJNcY8y
         7ZXXYoc4GM++oE+jnvIH2ca6uh01Qa9UJVlVuktYDhb87J3XmraIvk0o4xWKVpSn3MHJ
         HUF/t2plzFgx1kn9rWPSWl2P9zsH0gcfDlQu99PzEt5nnFUgUDevmU8n9pl17OOpgyW6
         R7gQvNops4rDqxpPmLoNLQQL4gDUH0tDAGPBPRzRqSPxzxy59+vJoxOIsZTAuovqjSB+
         5XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5m9qkWkkiGrMe/7E1EC5e0bYS8Dyu5QZ1EmRVUDZfQ4=;
        fh=dSBIYQpS5JvUobOPrkPcZD/5FaaRLkAn0Zt16067eO4=;
        b=FVEdcxXar6hL048gUfr/4LfjIZi0F/0NgJYxBu+8MGk92TRppE7juOtAO5tnGatHy2
         vb/zxE1yjx02xFhZhC0a442JSeKWRCkLpfeB0SSIRkCRhQUbrE8DIpgBZeBWvOClRCTR
         pKcy6TQYAwZzbb1kcydYKOyIdbx8olsHJCGuhDqRx/6Afs3KmgMcIXnCaMV1MWBsT64e
         mCswi0WUiHATcPeiqjqicHK1GI3VdHOzH0RPYtPqd45yda5qaZE0Ke3PkbRGLK914aRv
         XtiOn91TAozQUTVC09/NJGWSnDQlysASE8DF1RLP32J6l+rgkLg2erYmXLMF0c7HM7kl
         /bfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786660389; x=1787265189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5m9qkWkkiGrMe/7E1EC5e0bYS8Dyu5QZ1EmRVUDZfQ4=;
        b=JFkxe72QWAr2L0wE+w4jPF8fx5iV4JbqlCCGvKaKuPrbME2nWYiSGXsMVEX2opRCAF
         sxInSPiedtrsrQwUJIE9PH9VoSLlO/F/nMe/BquQv6cxxJsFZxTbdTVx6hpmQEhmKUlL
         tGP5MrCDpImwLj9wwjEti1nVAumndQMyLzkerODxgRnVzA8EqO1BegqHz6uMi9GfcG2h
         r7jWSmou9tRRN1/5qjMQV7Y0ZqdAjn1Vi2bm99zl4h8zoUNv9f+DUimmDUjMR9ODKHQC
         hhqb3nETHG2G08E0bwW/oi6BOVI/+1Qyj3/h/g27xJCodaQuNKZTEgQYn515XFJMqX/D
         voQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786660389; x=1787265189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5m9qkWkkiGrMe/7E1EC5e0bYS8Dyu5QZ1EmRVUDZfQ4=;
        b=FtYu2lHJThrIVxkFtp356qDzbgQME2NEDtncIY53/EmO2HlA4SHzyqsV4IfykeLxjg
         oMWXYHTtJMxlDYD77nTnS3MSgQa9KQK3QhgsTuWIgPhStFXS++FKrx+wjZossXbCfebP
         LwLxeVNMNgFj/B6MevaRkX3141gv64j727qtY7Ljom1dq1TCmgDLbemkgjqbxPF8mubz
         HJ1R11LFA9NTXwXmdImewxCytJGQCIXkHMQKW6piJzi/oWfvsLP1rkrmBnoQ4YGfAcW+
         AxENrA/rbljuBnQZVjodX8G0A3OmQXWd24tXc2d2UU36fXrh0XbBRM227+G+mrPRu1bD
         fFfQ==
X-Gm-Message-State: AOJu0YwKt6DGM9PYscQKZQObBZgpYMALK4LUu590LZVU+49UxAYiZVaw
	QfqG9LzXOVe4aofaSKdw2mWLTEHvwbYH0TnM7eX5wXTs5ceSsCVDGerjm9lDjRBb56hWOqA8iOK
	KoLw6z6PCy5y81RVvPATnOQqINlzMwNI=
X-Gm-Gg: AR+sD12g1Uonadc7KgPM5x2R/x8nfgCEmtGWonocf3cXQgVA85wP0vnqPpUqvuHWU8x
	9NNgYDjatLhQ6SI75/dPuMiDps9wWptB4xnirj4YOEw96HnKh0w2wTp3OHl0/Cw/oVFB2UsF2YX
	IxYsgLNrB8HTEZUTFLmnZOScP7VybQxBAVpBfd4iH6qDd+Vvv+viPx1fv2aAkoaj7aI9G0/rfMq
	CgIqeCiOsnXpZ1j8h/iXdxGy665R8PZNqDkzkLSYCobAL6KiiBq4DTe6Ev7TOqZz/1yTI46xDcA
	UzVpCKq0lYspntx0Bn+S2s/MCfy0EGAl9MtBFIlBjESJcwUQ1tzLLFVsop3A7awGaCHIJAiMunE
	Lq7pLsmqqMOSUQHD8exhsMDZuCP+v01hyY1lkCt7MHTtsbpazH7JE
X-Received: by 2002:a05:6a21:4c85:b0:3c3:8ead:6df0 with SMTP id
 adf61e73a8af0-3cc71cd5375mr1269370637.28.1786660389082; Thu, 13 Aug 2026
 15:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOZ_KysLYww+5TT8LQO-xNnubktwfyKYtxgAsBt44S-XmZHMVg@mail.gmail.com>
In-Reply-To: <CAOZ_KysLYww+5TT8LQO-xNnubktwfyKYtxgAsBt44S-XmZHMVg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 15:32:54 -0700
X-Gm-Features: AUfX_mxT17JJwLGy8aDu7XINDMUSp0FKiOTW8mCr8vntYc-TE5fvuf5i7N2oy8E
Message-ID: <CAEf4BzYUgrxxZ2DbXDe+bweKENhzNeeN5EnrG0D2xwLmm-yrTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] libbpf: avoid overflow in BTF.ext bounds check
To: Darren Carreras <carrerasdarren@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, jolsa@kernel.org, 
	yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, daniel@iogearbox.net, ast@kernel.org, 
	ihor.solodrai@linux.dev, eddyz87@gmail.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:49=E2=80=AFAM Darren Carreras
<carrerasdarren@gmail.com> wrote:
>
> An invalid BTF.ext subsection length can wrap the pointer addition used b=
y
> btf_ext_parse_sec_info() on 32-bit builds. The wrapped pointer passes the
> bounds check and parsing then reads beyond the copied BTF.ext data.
>
> Validate the offset and length with subtraction before forming the sectio=
n
> pointer.
>
> Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")
> Closes: https://issues.oss-fuzz.com/issues/477315119
> Signed-off-by: Darren Carreras <carrerasdarren@gmail.com>
> ---
> Changes in v5:
> - Rebase onto bpf-next commit d114bb989367.
> - Attach one diff-only patch; the v4 MIME body contained a duplicated dif=
f and
>   could not be applied by CI.
>
> Changes in v4:
> - Drop the selftest because the malformed length is already rejected by t=
he
>   old check on 64-bit CI; the behavioral divergence is specific to 32-bit=
.
> - Correct the Fixes tag to the commit that introduced the pointer-based c=
heck.
>
> Changes in v3:
> - Remove the nested mbox envelope and mail headers from the Gmail attachm=
ent
>   so Patchwork's generated mbox applies with git am.
>
> Changes in v2:
> - Resend as plain text because Gmail mangled the v1 diff and Patchwork
>   reported "Patch is empty."
> - Include the authorized DCO Signed-off-by line.


It's hard to review and reply because you didn't post patch inline
(please don't do this for subsequent contributions), but here's the
gist:

- /* The start of the info sec (including the __u32 record_size). */
- info =3D btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
- info_left =3D ext_sec->len;
-
- if (btf_ext->data + btf_ext->data_size < info + ext_sec->len) {
+ data_left =3D btf_ext->data_size - btf_ext->hdr->hdr_len;

From what I understand, you are trying to protect against corrupted
ELF that specifies invalid .BTF.ext ELF section size, is that right?

And your fix makes another assumption that btf_ext->hdr->hdr_len is
definitely not malformed, because otherwise this  btf_ext->data_size -
btf_ext->hdr->hdr_len can underflow, no?

So in both cases, if ELF or BTF content is corrupted, there might be a prob=
lem.


+ if (ext_sec->off > data_left || ext_sec->len > data_left - ext_sec->off) =
{
  pr_debug("%s section (off:%u len:%u) is beyond the end of the ELF
section .BTF.ext\n",
  ext_sec->desc, ext_sec->off, ext_sec->len);
  return -EINVAL;
  }

+ /* The start of the info sec (including the __u32 record_size). */
+ info =3D btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
+ info_left =3D ext_sec->len;
+
