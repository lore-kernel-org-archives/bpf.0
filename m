Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB6343D85
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491582; cv=pass; b=tM+FxT83/ad7HPbNM0d49zhu892672LgRKr887qgV0PDs5WY1gl8nT0Yv54FlW1AwQdjaULTyAcAHoKfRA3cWRxWYoLpzVvbChVhKjHLDHqZdr/BxzWP9P+TOuBB5NDSWBJaaV+VdSkNdx4TgfIiKigKTG6nskUpGhpcb6tHFSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491582; c=relaxed/simple;
	bh=1Ao81rLLMJ9T3ZhPayNjrIz+C2kFvFVa1w9KQcaOTbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boVeIO7RzvAbtGK5KgUvn6RBb6FYIVFb45N1/3Pv+krsJSdkGzG/HVuyD5K6Ep2CyBvr2i5i15nVjnk5/NAl9po2cGYfU9nrmBQbVIzZ6Fc4pPhdNEiu+wfMvHfbMSfNAdc0ewkdDFJjtZVVOYEJzmWbZvIiIZbikyF608Yi/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcrVEnSB; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcrVEnSB"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501418152cso3764624d50.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491580; cv=none;
        d=google.com; s=arc-20240605;
        b=iIqC3obA7JL6tjUzgJo3EorI52PuCD/4GmfpaBT+BEBUC5PfBXxkOme2vGq1qf0zum
         JkjSRAQ72yri4+xVsHv5z1eu8+nQcUDWtBSXYpxpbWO8CjZMENj6uJFGJ0kp4yaPgb8x
         HWVzQATg6sheh4QHq3oPOs5KdKrF3cmRFAGAzwkUA/Mg/q2C4YLvmqarQnZ9iODiRDT9
         okeoPVHvL3fSDkHzz6Rj6iwXTVx+f2JcBsGtobqX+rxjK8gFKzDPkpRdrIcJaRRtKew+
         U91MHvb+nFO068h/XVjWVbhKXtTz7g7qINGJLRdZ1NWHUsxeeJ3gdJ+jBycRf0MZ6vf3
         PzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        fh=b3R+aVqOM4LdUW16FqF+p/6Vla/mrEioQ8C/6UdKCzI=;
        b=HNlemk78Ky0a8MRwKsipkyn1zuXHhOnoM3d9BesvNQk0Ce6d8rdOQdWjNPtZBL8lA3
         1FE8D6kzKQh3THA0w+HdnEiJHjOEb4AuNk0O7cvASWGikDrbVe7cevb574N8OBz6jXb8
         I52z9d3m7Os+0Bso9PKDjDb/ilCI0fw9JFTpnyIwHugI5SUD4TsXUeQF3uvvlrdYz6U5
         3l8K0JWh+fle/Lz18vYZHQAPeNldKEq7itHjcSrM5t/0mHh1ukN799Nz4W3GzX1Abqi4
         8oroXFYxAmg1Ntl1rEiUPrRBsasZFzeh0mKsFm3vX2r8baIiTEzHAhFCQNGxKY5rSnms
         ameA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775491580; x=1776096380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        b=XcrVEnSBzqObcxdel+GHkgInMaZKgb3qUAZaCNqoARA3InJt/2N/OC5rL6XKpYm30H
         i4YjqyZTeAMeo4dMFr7uqDKq4cNp5CqMNBRf3d07RJONWe4xqXuyJhkH6DZiAEaztuDo
         9DyW4Otfiv2xAv2T571/F3hVwN4iWYnL5zJof1XJgf2E7s27OLCozFIeJ4VHNyQ6uXIM
         XLIWxCvaKhE3OFnCM4ZLO59m+Rv6rylnv7j1YOeFyuOFFJDtxVgrpQ431EDpzTOfdjmc
         0jQs2XdHPp/6GxV947NB9N0x5dS3oGCkR9kZnyKPLcNh53mbSKg5CauAouJJEruZJjDw
         /MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491580; x=1776096380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4k6iOIVi59Lg0iTaZk1dsAN/oP6YbMRjWJFQdPXIOs=;
        b=poh/+lgrPnrqlYgqToBwmae0P90yCPHKTmtjH6Kmtm+8QhqeWbcXGQhK6F7LT8OaeN
         +WqKM4ezZW+s3JsQCv9wlNMXPD+9eTZ0Q7UgyG1G55px9aBkF0Y4lpLVVZ++1ZqXitK7
         48FK1CgyYoCZg8xQaNLxMuEhjiADypHNvqMmUWuTTP02y0nLc0KJ5v5BPDp+WDH3wRtQ
         1tEt/PcYS7/rhPuRuVMV4/fDtPoEnWIZ2Lvamo8UchT1QC682gmf2hrd2inyEIzTsl77
         44NDJn5CrM2vFzjbHjhkC/ZDbZaYOosUiKiviRD8vpqZ7n0f5qO4LsyrxKb/isi6ih65
         v7Rg==
X-Gm-Message-State: AOJu0YyNYzkBRb7Ai6JkcCINMKgad5s4Bi5Yoolm3g2B6aaBFMRnoMSt
	IN+QFwk05vHwO/N+DLb2Mj5Uo6ynnQ3oS3CUvf9rKTgkjm9drIcx5o1HjQElp9wBKx1R5GKij/5
	gA+PRrQFucyVaAamLZvv57UpepArldZQ=
X-Gm-Gg: AeBDievo09uzyQnPkVKPdhiliExpjC9tglYGu0XTXo/5mE65gjK7xLs06KZorMqcvV7
	lXqYEoGFr4TWCdglfbExuR3wIxcwEqicqU/qVJRRd00iWIKzx4MPiI79sIekObq0OvYhU+KWRll
	wd+7n6RGZ6jfzadG3xWkZRWwzOaTPjgI9FD3mNO0QfnbZQZrVbA9v23Pc1jx/QgqsWrOgAszSLJ
	RF1A3WsbP7cqDmiA+ee6ZIdyFZ9slf52B2W59Z3YoKxaXGWO5/UawlvidJmW4erriNK396mk/si
	E2hX1+vNFQutNyi61ULJi3D7XV+oTyOSNORHxirZ1g+qklK6rhU=
X-Received: by 2002:a05:690e:4853:b0:650:39d6:69a1 with SMTP id
 956f58d0204a3-650486f2bedmr9450184d50.4.1775491579797; Mon, 06 Apr 2026
 09:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 7 Apr 2026 00:06:07 +0800
X-Gm-Features: AQROBzDlDluK28vEL2sKAYGrEn54l6_RzgjNnCFfO8DMO8cybYxLjy0EB75dedU
Message-ID: <CABFUUZHFHFy8E11QVPxgkpdS16-f8ieTmHzJmEU-6pLUy2hWjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 11:14=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> When a BPF sock_ops program accesses ctx fields with dst_reg =3D=3D src_r=
eg,
> the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
> destination register in the !fullsock / !locked_tcp_sock path.
>
> Both macros borrow a temporary register to check is_fullsock /
> is_locked_tcp_sock when dst_reg =3D=3D src_reg, because dst_reg holds the
> ctx pointer. When the check is false (e.g., TCP_NEW_SYN_RECV state with
> a request_sock), dst_reg should be zeroed but is not, leaving the stale
> ctx pointer:
>
>  - SOCK_OPS_GET_SK: dst_reg retains the ctx pointer, passes NULL checks
>    as PTR_TO_SOCKET_OR_NULL, and can be used as a bogus socket pointer,
>    leading to stack-out-of-bounds access in helpers like
>    bpf_skc_to_tcp6_sock().
>
>  - SOCK_OPS_GET_FIELD: dst_reg retains the ctx pointer which the
>    verifier believes is a SCALAR_VALUE, leaking a kernel pointer.
>
> Fix both macros by:
>  - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>    added instruction.
>  - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>    restore in the !fullsock path, placed after the restore because
>    dst_reg =3D=3D src_reg means we need src_reg intact to read ctx->temp.
>
> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when ds=
t_reg =3D src_reg")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@=
std.uestc.edu.cn/T/#u
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> ---
>  net/core/filter.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..53ce06ed4a88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                                       si->dst_reg, si->dst_reg,          =
     \
>                                       offsetof(OBJ, OBJ_FIELD));         =
     \
>                 if (si->dst_reg =3D=3D si->src_reg) {                    =
         \
> -                       *insn++ =3D BPF_JMP_A(1);                        =
       \
> +                       *insn++ =3D BPF_JMP_A(2);                        =
       \
>                         *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
>                                       temp));                            =
     \
> +                       *insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);       =
       \
>                 }                                                        =
     \
>         } while (0)
>
> @@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>                                       si->dst_reg, si->src_reg,          =
     \
>                                       offsetof(struct bpf_sock_ops_kern, =
sk));\
>                 if (si->dst_reg =3D=3D si->src_reg) {                    =
         \
> -                       *insn++ =3D BPF_JMP_A(1);                        =
       \
> +                       *insn++ =3D BPF_JMP_A(2);                        =
       \
>                         *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
>                                       offsetof(struct bpf_sock_ops_kern, =
     \
>                                       temp));                            =
     \
> +                       *insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);       =
       \
>                 }                                                        =
     \
>         } while (0)
>
> --
> 2.43.0
>
>
Reviewed-by Sun Jian <sun.jian.kdev@gmail.com>
