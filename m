Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35A39EF0A
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929064; cv=pass; b=NotdffChUxV7bs9svwfPG+f/82UmqPTyRGELGMieFGaqm45lL+Va/Yas1RA9oIU1f+ekB0ka6cOYj27zieBMEjFKhXPGjCKhEXBePnncM2MCdaFHZJJMzadHbzrDACxd5v7iFcpIi55fEy+wS9/pmYDT5xlC4FmPz7Iu0Tu7zd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929064; c=relaxed/simple;
	bh=62OIGrsAlLi1rdGfubDO5KjxvcKbptRJ4dObLOMGjuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af4LW4xEgbgVbNMCtfMxjvy9TjdoRvdcPj9wGa21RwbeXPVJYqescw9PqY/xW+TX31iZe3evzFffXWh3FOKO62uVdEiJq3NcBrkR1NexeGtils5gwXObCILqOrXgLVjAJQ9CqGAkLIggD2EMSzS+k9QGVCLsBMV8OdC/Y1Z2i+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KgDlyz24; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KgDlyz24"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-86c0e4dd49cso69731927b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 21:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788929061; cv=none;
        d=google.com; s=arc-20260327;
        b=KNTokqvFCG1MX8WJGdUtnQoEcKKGnNiJFCUzhw8ar5gSxDhoasu4Aa1HQutCHvTQhl
         JQYjuDql/RalvGQf7By88F6/t6emRxKbaYYI8XpiuCgKegxwhA7hVPXS982ENz7EwaSM
         51G0+or+YkAs5Ip9QYzSr6APZ3WDlxdow1ptRMAyk3awhDs/oN/OvQ9uHB/nDBixekZZ
         KHoNRbdtTgpPO4fyu1zsQfLMW2y5TonWpvxgsPd8zcZs6AEeXyX+T4itZtXDwbCMvXUd
         L4sfuh4jqzuaLJceyxZrTJun7hGFofaX/NaDdBWbK1LWlM9WwVtzrB3C7bxqlNj3Ny9R
         4cQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFIjJx0Nar7vhUCg7kIa8rwv78ZFcuH0cUsFUt6eVfA=;
        fh=ROhOUqndz7siXWOvnrz6VYUsprQW1Zp7OWkWKMe0imU=;
        b=Afw5oF4yUyNjbLk9gKzZiik3n7J9cVAOoq3CTP+eXBxHJ3CRe2mpqfDA4BCL63IhpG
         n+/QnxLh5tXVaX+ht1TKlB7p5Z7ly13AirdrXpUKyG8k6FTxS3OiTy0chp0sVPxMGoVE
         BvFqoxv3ukFMbzMfedIF7jEabc/plvaZyOqgSoPvC9jrEz25DAY/lyZbrKvLtWicHphD
         VVL2hbWo0vpp1SHbpBna0WIzldgVzsSHl08zHfDbCwRst4q4GXi4dCswg+KEsuP5AqAb
         Ksr3B4KBtXRNqKXspCxbZ4CsVv+i8J915qvUe8g9LZhL/dImJxucxat3N5udRIP0F+Bh
         IeIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788929061; x=1789533861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFIjJx0Nar7vhUCg7kIa8rwv78ZFcuH0cUsFUt6eVfA=;
        b=KgDlyz24TlRjxVhoF5eToBWuOm07RqHKh24TsXBz5IPP2PgKkplodTYrVi/s1eXo7t
         gGUYO4nZLrnOc5Ff7Zua7hoEV5Bi3thp3smw0uRotagfs8qOXQ3pTlOW/+GIi5QEtze3
         XbD7aLnuyATZc/BwQawp1FY79yowRwJlND6x/kt872ORDDePQ3CgysZKJC6T8nQqetbQ
         FF1cwiK5iuCG+So3T393d778YhBxUEEZmpKXIal2/JgYlMC7N1nlHvGcvAA+I96cDiSh
         VJuUB8C0nHSx6Uy7It/Jvk15PdDG/h4Im4+14ZqrNmQ4Sf8WdF8vloWiwQV+lZffS6+q
         R6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929061; x=1789533861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFIjJx0Nar7vhUCg7kIa8rwv78ZFcuH0cUsFUt6eVfA=;
        b=TQRhBDwLKt/ZU/kktITbfjzzRgfkB/+bNBgkGYA1DL4oiaqw/dsRTbiz80GJkG9sU6
         llRwzp0b6nOu9XJ19krg0pnNLDKivs+hZ218wfeYBc2prClz4YVxuTeBzg1/0aoCa3dB
         aVF4mD2yos5L39A3EdZxsVj1pWdfCG+cnQVDIYB9GriZTVU6U1Ip6N3khnuRoP1Dzxn4
         y8K22DnUE2lh8n3VNbqxjTzwr2xApGZvfQPD18/OooWblu2pL+5GkU0xSTltUbVJbSdn
         VWRcYVebKVdiyEfLmP8UxmNjwbYAdnC6r23ttf4+fKt+PDaV/+w5Sqwz6ZDLwricIWlw
         iMIA==
X-Gm-Message-State: AFuF++nFK5ivh4xmmlkIp+Grwzb8rr/nMBXJHfl8ql0U0stN3nDOa78o
	JlDcF7KjOYbExSl3Qx9lVWg8T7zH+8Hb60aExPCztLHeWz8ZPx+kQIPHMYse6NOuM4dBd4FcI5P
	1NSOIWmWizRubqjAlbYCS75zLRpQwyKWM8nYznfTFJA==
X-Gm-Gg: AYBFou1oaggHdpdUs5W89JDffjULDanMvVLPnbmMZExYa7M2DGY3N0MO2lNPIWFRchr
	lIToCQ5O8dyDA42ZIrBYWIVMVmkv3q8723Dm1t7MoSMa6EMu4USVTLe2TXRJ/8Mbaa5mwWHWwfc
	ZsK29k/CcQtqtJOCKvEmuqfpUQavcelajGFBE7mTwJJNEP+l3ht4z+IGPtA4vIGDfqcoaKEAuvd
	TdgRdOlmmasB1RYgApSYRRPpRvdDuNmFFICc8C9lmp7J2+Ayek4tTLrWESIOT7p69TDHq5oy9hA
	C19dnkDwTm+qfm+xbsaRHXfTVaEGUxiZI+Zm58d7A+iYLxGEdSxPgl8=
X-Received: by 2002:a05:690c:710a:b0:873:5c7b:c0fa with SMTP id
 00721157ae682-8735c7bc5b3mr93358697b3.50.1788929060853; Tue, 08 Sep 2026
 21:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903104358.29228-1-running910@gmail.com>
In-Reply-To: <20260903104358.29228-1-running910@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 00:44:10 -0400
X-Gm-Features: AcwNN1XHmJSjRplkzmE5s3GzHdAM9caxMtmJWuRuOUHEMucd9ByHpXggoCVTtUM
Message-ID: <CABFh=a5=m_WrEoEQ6UMGkF-3_s00T-CnAt3rrp3gcjozZ0juvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use kvfree() in xdp_test_run_teardown()
To: Zhixing Chen <running910@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:56=E2=80=AFAM Zhixing Chen <running910@gmail.com> =
wrote:
>
> xdp_test_run_setup() allocates xdp->frames and xdp->skbs with
> kvmalloc_array(). The setup error path already releases both arrays with
> kvfree(), while the normal teardown path still uses kfree().
>
> Use kvfree() in xdp_test_run_teardown() as well, so the release helper
> matches the allocator on both paths.
>
> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  net/bpf/test_run.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 5d51f6cb7d15..513354e928cb 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -205,8 +205,8 @@ static void xdp_test_run_teardown(struct xdp_test_dat=
a *xdp)
>  {
>         xdp_unreg_mem_model(&xdp->mem);
>         page_pool_destroy(xdp->pp);
> -       kfree(xdp->frames);
> -       kfree(xdp->skbs);
> +       kvfree(xdp->frames);
> +       kvfree(xdp->skbs);
>  }
>
>  static bool frame_was_changed(const struct xdp_page_head *head)
>
> base-commit: 7bf591f26545f5776a4e42d08c06fd94469766dd
> --
> 2.34.1
>
>
