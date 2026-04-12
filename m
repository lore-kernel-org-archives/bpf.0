Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352E3630B3
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023663; cv=pass; b=jvxch60ewYBSXVKljO0yxnT4SwX/rhKVb3IrKNy3yy6Gyr4FPJQb69DMsLOEQSyVVaVYwXcKrqABy38Mu7T1brGoWdul6RCyIne48lr7GsZy3CRTamFijjSKZLqzzxMcsy+7phpF+Ut4wfP6KZMjgrmlnZijPlDxbdC26LglEWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023663; c=relaxed/simple;
	bh=NCHrDDOBGarLoM0mQWUGTaq48lcerKT5zxvwQk7EGJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9DZeA3RrNF6CZxZJtKAnxB9Sj4I+Hif72tmHoa+0AzQlao2vvY9cStNt6MDxOn5wuFCDRQPh8Q0qlXkqtwZ3QjtsIjuW8uvUWXrs/I7XOjYp8JqoK/6PMno9tIph8b93WbtNkIzSCL5b8cE1UOkZUW/MyC17uyNdK2ypGFJohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtORFKkM; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtORFKkM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so2412949f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776023660; cv=none;
        d=google.com; s=arc-20240605;
        b=Vub7e8ARP5kQKO/zqyl2RbzeXod/eX1aVulSJVzeA15TEqCaYL05ITfSBFug1rYP8n
         QTQtKW3BUwJ/4nkPf8fjDx7WI/oFKLbwmAET7tJB92hNLGiHa+1Ddj0Z///QHLZDROmf
         ZcH6ImvGO6aQcvGfKyOMYNLxkl1WRo8JdxapVvd54fub/T1u5nIUyAC9brpp8RvdROgd
         msVmuY273Nz3pgJEb1ItL2mFfkNjybes+BnL1LDl+a9EfspvTAtYP26WJhjaZXuZDlSp
         NuD3WkxzTjXJW4wjew9J7+oTk8+5lU075UbxFOJvw5NayUvYR5mI0dNa/pOr9h7UNDK6
         QV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP55MS91k5VONvuIEFAJaZvPvdzEIeCKHRbkPmnOi2A=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=SdfLWfsJmX13aVfhZJi2474QAxegXHY/IvBEsLvXW0XYTJ1XNzR+tU74pcuVaG+/Y/
         M6Z+z/ZlYxMsq6EIGN+mDgJhtAWRhkWkyDb+7mDz3IQwlgBt29HN0hKP3pFPnA18s9bJ
         oer/FAQAW0FabFbIaclfVxpcWzQZu9p6QVbYRbl421yOfabY4YdGt36tXVxaH3gBtBDX
         lzdkC4PxR73dlzGETGsuGsBY3OuSA7lS4g6kmGynGSP53ZZ6PxkFNdesPEkPSmaV7tTR
         xyIoKjEw229y6bUDgkqYV0Xn4DRkOhU35SXiiRQvqwH8vses3nN1mBB9wamxDKnAT/oF
         Alow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776023660; x=1776628460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP55MS91k5VONvuIEFAJaZvPvdzEIeCKHRbkPmnOi2A=;
        b=KtORFKkMIcvN7wAsbl155/ivoeFzmr1YVnX2nwW+l1Nr+NN74Jso56oX5Uf8BDIfNU
         HiVqhUlSkKhm9TsBAfYONLUw14iPg6S/b1llc5hKW3muzJHliKVfBhQdKoKQBB5gHcIn
         XM5wR+Hw3DUFvA1B3DkQH/N7EujMi4vUFCrI70YJndokIgPYwipf/ZF9aVkY/+uoUn0a
         CK3DfQI3QJxFWelKXJievmqzgDkpBuQwTaz3HJMV3pT0CuktEX8HPDcygWEcHEfr+f/l
         Us3IrMWuh57BTem733aC13T+3q2IJ+7HPE6Q3J5GCNBuQyzO1NgY4VOSNWcmcKa9ggWR
         78kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776023660; x=1776628460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP55MS91k5VONvuIEFAJaZvPvdzEIeCKHRbkPmnOi2A=;
        b=IuWLqfU/LQTtHn+qzFzWyStkfbCpYgXT4dW7SQOkwWjjst1zCsWTwxs5yLmsNpbxwZ
         PnJifPuhm54atqjBce2tRTQSD+cWD/byHmlbTNLzNJFYob2RILMmN06yLGpoFkYUksKY
         q4URyEw6W9ed+kRyHZaFIZpUqDfUQsLE+s959dg6rTrcjFORln+2EWgqy7cYa5i72lg/
         b2A0HRDpswVlJNGcx+K00OXX2HZZb3Z38173JUXkYtY34p5EhgSiHhsPVJ4z54Rh7dgo
         x8a45ynIAs8bdLLyQr4+PAc7PMYTS10vjrTnZSDjU9KAejWAtXuDkUJo3nlternDJ/K9
         mzjw==
X-Gm-Message-State: AOJu0YyEVgaUpXtRTr6KoUP8ce+zyUhw5R/3UFA1q5I305dhJa2XlfqN
	Ot+gC+WT3nmGpeSVs0nPWPHoGBtlSelZofVskp9VzPKqaZYMYsDpD8BnuMHGuBMxTVyPW57cuKw
	2cS6ze8qkX98/EAa/5rKfp5MRPov20A0=
X-Gm-Gg: AeBDievSz9EF+5r3R5OfEV/VGTpqbP/Ykb+NnRQJVxemI++CJPgWf03NjO6EbVOTVYB
	LqSb/6odvRqxwIGLo3+r/tVpSDODlQTy915PDhkH64z+D4IJG5PRJ7iP+I5hfS/6PLAfs1CBSNW
	U2fQeRz+61HD4ZoexteCQJCc1hNXBwYauNWH4DK6wWd92jfHzw/wipVtyRDQ/QBIrCKBR2Q57E8
	fRoJDVfm6iJ4lxQTB3EAamzLCS0lE4CvcXPGo8ITzM0FHMVOPbW2WUArXEMBmG5Cvo0GIUzk5AZ
	/OAr2m3Rycj022omXxdWX7M0647IlEQZHg0WfRspagl0Jx9JtFYYB7OXE6VCUzRe91Z54VDhrFu
	qPlGmBcL5JQIqaBVOZjzbScaekQ==
X-Received: by 2002:a05:6000:1144:b0:43d:7403:4b57 with SMTP id
 ffacd0b85a97d-43d74034bfbmr3258002f8f.10.1776023659932; Sun, 12 Apr 2026
 12:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <20260412174546.18684-2-emil@etsalapatis.com>
In-Reply-To: <20260412174546.18684-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 12:54:08 -0700
X-Gm-Features: AQROBzA-eRymypMJWRYcRPv4SZpOngpA1-E2OhWwnqlT7Wxz2z3GTsPUJBOZET8
Message-ID: <CAADnVQ+GpC_9A_Y24upLyLEYy6Ht520eO+mnbGWfRXHn+g_Dsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/9] bpf: Allow instructions with arena source
 and non-arena dest registers
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 10:45=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> The compiler sometimes stores the result of a PTR_TO_ARENA and SCALAR
> operation into the scalar register rather than the pointer register.
> Relax the verifier to allow operations between a source arena register
> and a destination non-arena register, marking the destination's value
> as a PTR_TO_ARENA.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Song Liu <song@kernel.org>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
> ---
>  kernel/bpf/verifier.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1135d373e2..9280b3aaae46 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16655,11 +16655,21 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>         int err;
>
>         dst_reg =3D &regs[insn->dst_reg];
> -       src_reg =3D NULL;
> +       if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +               src_reg =3D &regs[insn->src_reg];

removal of that re-assignment few lines below got lost.
I removed it manually and applied the first 2 patches.
