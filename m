Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D31B4223
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782089444; cv=pass; b=NLIa9gSlRa/zknnI2xhd6XqkZ5xCMwx1O/mdsCCS0e9pfzxJmdhve3HB+TlmXuL1OTGVebGuGVwL+1kQ4nJF39XWEQVQU2howxQQ2b1gDJ2FsIL8sRTi/eGHw+LfpMrsGERhR4Es/3PIQDarohqRJfXl5HOF1rPYNtXlQGr9wZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782089444; c=relaxed/simple;
	bh=63hAvK0P+13Cg1qv9m4P4nXfQ5cLqRvPBO/ZWgGLbbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOVEZ+uBN+ZU/jZiEIFtnq5g1lf1zvqoFPGIbyqXD0ecBNb5LlqYN1DlLGAigRC0YvXqFZrn/CBvaOFL2rCZdqjyP7rZGMsZxjW0+/UyVEvML3fxVsVfylDc7dVAbwyMrxFs93qDC7aqe24+jkcbPqzgn6O2AGWclE0bmoUmFDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svXfqEVI; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svXfqEVI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so667217a91.2
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782089441; cv=none;
        d=google.com; s=arc-20240605;
        b=D8HLJYLjYgwRfp3WycfBQSPaSDBEL3tlgtaHCcqjGQN+d6HnwetfjHXieiiTvHKufj
         yLoN3wA+0yAdd05CLCg5UNdr+KB0hmc8zSB3ZnAF7Qg1doRYis4Wq/ZRBDIWlrPfT9d+
         rnsurwv4jKEvQhai/mEF70Yg69POENgiisc+Px7g9EDrK2FpEZmqHcqXYbty/JYkpXNW
         kfzVlllgqQwuGyTGzo6A3omB0AeTToKv6Gmkxn/cR1HvRQfCgysTmCl+8VhdYhG3o05J
         8uNYEci0wMefirFfWkZYZvl8ddukJDsXpA1GWXpyGuZpPp/S3Pz7kSFsf8HWC6Myge/b
         hT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++nZIIXfioR85B1LhnWkjS9gFw8En/kZb/6oprgdiBo=;
        fh=fONPJTKTBjTILHWyc2KsawEdxOEh9gEC8ZZoewLwYVA=;
        b=f1RsJrvJ60WHig7urtkcpXr8RcnxZiBQyvGmoeCBlr30BzhbhdSNBIrVmh582H3XQC
         oubyZcKmmnSePQ+CGyemqDXseetmQu8YtaKkBMfRDOljQed4pFwUkumHQBlK4wRa7SFQ
         7l/dg3qBD3dhigDqFLGJoqN/+lTUbgC5QomO1FuDVOYLOX9U314Bzs2XjdonQhldzdR9
         6YtrhqQTQU4rIL8gaBtX9OV44xPVHenuu+QogrBOBon8k12mWDrA1lxRuiZjeOmQTnqh
         yrNmBT2evs9510YnwspazmGfYanRJ8muxP8bm+AgvHUebuPVfeQD4XecGeiYDz6wx5R2
         qWCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782089441; x=1782694241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++nZIIXfioR85B1LhnWkjS9gFw8En/kZb/6oprgdiBo=;
        b=svXfqEVIDVyoNNcKkhKE+/urjbdfl7dXdogneD94bwn7RM+J/WZUdXizvszcxcqgP0
         VjCVpEUWKxQ9yrQoFGEXZcQ5xC+iKWrJgjuD4r+s04aA75RjRpxM/9sRbGNmzS8sTKqX
         Zhf9u3JrrpO59QhPmhrOG6Ezae8si3a8xNXxJroNNV6uoxYStZgCOblF84MwhdSD3TPg
         zluSwitZbZ3mdoF4Qj822tf5bpDZRUhg6a+CV2YoHSYixU0Jeqin19PvgFBi4WEeP3gL
         i9eCg13Wqmd6bEa5PdPhi6rI8AIQAwk8++xNa1kGKQtXh+I6ag4v3/SmNm28mMXz5k+l
         kkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782089441; x=1782694241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++nZIIXfioR85B1LhnWkjS9gFw8En/kZb/6oprgdiBo=;
        b=dyLW7HdyxiaU0QbtgT0RrJXEIwDIA6bffQ1PVtBtqQ5EKaeHNIJR18ylkZfkZ5BV4k
         Xxz/CHMVFv5iqpqA28gg6sGHiOhgzaERROphgrcG3XdE+BYltdX48HFVYsM4utSkMAu/
         i5tkSojV7q4obksnH0Dde3sre70VqWQ1seq2uKyNUVYwPbk+46PBEhpT/uFR7ZdDb9S8
         Mt1ZpPfbkK/m+LQoBgymFpmiJmYcuf/CxJbRID4mopy4VK5Il+NiCFAKm5OAS6omkI/F
         e6GzDa9O5z0H3cAZYXymSWvR8756nIr/wh7pOfZBDSTTolYOXtF6C8gkmGQKxeFq3I4E
         n43Q==
X-Forwarded-Encrypted: i=1; AHgh+RqxZld8rpMVPHkcYb60HKbTLBuizH1llHuK1MUOAulzQOJ+W+dtZLmBz6FdCjZPLwOfR4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPJaIk5aBtcqBsFmpUeNdNKY7TwkD6OY/ChwNeqewjxovGtdk
	uEhwNtQs/bsfssbZn8NLsfMRkYDNU/Sz8TEYXBkDZ95FL7ncmVOLBa6QPURmEgPsaamd3fv1oz8
	nfFi0OpJVGABXh4z25jCn7jaIKrxkC+k=
X-Gm-Gg: AfdE7ckZeseNFa0+dghef3dl6wXB/3nZrZko01iI3u9lDlzZAIfxWMB77IIWupNHMSw
	BpMWiUiEOkUQ9S8NmF2bKSQPzxWq1QBG/futpRqgR84o0YD7axs6wMvnHS31QtDztm2Y5pzyCT6
	qbGvoH6ByZi+xljF/f43L83rbongRpy2+vVKMHzgQbp6J4k4l23G6iIadww5L59mDxQ6UT+kY9o
	T4d2R4rvrmeJKgkkWufKxHosK8IHMvchWu84GFjHSSRCv9Ihw/9F3vS2izzJtcgoR1C9VkN+Gt0
	moRjouCCpGtcuC6UUUH3yxCkdHA7qT29tQhsopaTYlrCA+vNpQgnoRWTKWx24uE3ErkxXFnA3PL
	dM/LP0BvoRQDWmw==
X-Received: by 2002:a17:90b:380f:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-37d160d9177mr12277371a91.23.1782089441027; Sun, 21 Jun 2026
 17:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
 <20260613-f01-03-scalar-add-bpf-next-v2-v2-1-ce07bec3f72b@mails.tsinghua.edu.cn>
In-Reply-To: <20260613-f01-03-scalar-add-bpf-next-v2-v2-1-ce07bec3f72b@mails.tsinghua.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Jun 2026 17:50:29 -0700
X-Gm-Features: AVVi8CejstBP2Lr0-ueAypLuIoufl56JFGdN5oweKOCPTLmUjg9EiRBE_Ca3tc8
Message-ID: <CAADnVQLSh7TSgKogAkE3Lhuqbu8296axTu+i6xFPKHbANSkifw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve untrusted memory pointer
 type on scalar add
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 5:38=E2=80=AFAM Nuoqi Gui <gnq25@mails.tsinghua.edu=
.cn> wrote:
>
> scalar +=3D rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with t=
he
> pointer as the source register. The untrusted PTR_TO_MEM case returns the=
re
> without updating the scalar destination, leaving stale verifier state.
>
> Handle the untrusted PTR_TO_MEM case before the early return. Addition an=
d
> pointer-minus-scalar subtraction preserve the pointer type and keep the
> existing "do not track offsets" rule for untrusted memory.
> Scalar-minus-pointer and unsupported pointer ALU operations are still
> rejected instead of being accepted by the early return.
>
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..26c67c53166b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13729,8 +13729,32 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>          * Accesses to untrusted PTR_TO_MEM are done through probe
>          * instructions, hence no need to track offsets.
>          */
> -       if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type =
& PTR_UNTRUSTED))
> -               return 0;
> +       if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM &&
> +           (ptr_reg->type & PTR_UNTRUSTED)) {

do not introduce line wrap.

> +               switch (opcode) {
> +               case BPF_ADD:
> +                       *dst_reg =3D *ptr_reg;
> +                       return 0;
> +               case BPF_SUB:
> +                       if (dst_reg =3D=3D off_reg) {
> +                               verbose(env, "R%d tried to subtract point=
er from scalar\n",
> +                                       dst);
> +                               return -EACCES;
> +                       }
> +                       *dst_reg =3D *ptr_reg;
> +                       return 0;
> +               case BPF_AND:
> +               case BPF_OR:
> +               case BPF_XOR:
> +                       verbose(env, "R%d bitwise operator %s on pointer =
prohibited\n",
> +                               dst, bpf_alu_string[opcode >> 4]);
> +                       return -EACCES;
> +               default:
> +                       verbose(env, "R%d pointer arithmetic with %s oper=
ator prohibited\n",
> +                               dst, bpf_alu_string[opcode >> 4]);
> +                       return -EACCES;

No need to arbitrary rejection.
All ALUs should be allowed.
Something like
if (ptr_reg !=3D dst_reg)
  *dst_reg =3D *ptr_reg;

pw-bot: cr
