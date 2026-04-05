Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD90282F34
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432995; cv=none; b=Omci77n94+MHUuBugeC5SW4zNx2B1MbzeaOSZPgKsLrGFYfUHffbhqiPa/8B6VGuoZufy4KP6Kx+sCA1m8VfB9tygVuvukPK2wxejcNdNxSJ6jfm33W5HlNpTUO5Hy7g7LWkJgFAT+wTucEKiQWWo1BO58XiDhBSKFG2dVQLjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432995; c=relaxed/simple;
	bh=UuxRCYBnHXVCIUC2lYpysNUxFrS3xTL1sRQnQsBThTI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CK1lINaqd6yqBFBJiK4pHIhyCLRgc7uSfys7XI8QQcTt22UZsFSJTcElatnYvNt2Fsnw5AS7iB0lJgwf1ke/zboeol/Z1Vvulj4/Q0mE7ajF0j2IaE7bf8yIcIzbBF6lXxmP7skFoGhylleLAT47LibeKYdpkaeuSueIK4yAWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=G2kMGy6p; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="G2kMGy6p"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so3080640a91.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775432993; x=1776037793; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUZVBN2VN4vnEw4Br5X4PEYZMIf8IsAQPOGK1gD3tCE=;
        b=G2kMGy6pTcYp0CwkVO8L3CE0hricXF/suYcSyykCS+BPxGgSDM+3c8h0KqccPejTe8
         ++gKJUAF9thas8dat8Mz//iUeIJUTMuCJn43PpPDo/OGVwWine0I617zjj79E3fwCp7O
         /G7ZnRimr+1+cjxcIyAriRA+OUnYk1DQVlEBmG9dVn3ldNmVDzBH6oJpCCIwvR4p/Xvb
         eGtzJO2o5T1Z8C42QhLWyrEu7A+JPL71qp2k6DL43/MxCfccVit1PWiad5yckV0+Zxy7
         7jrO6+dy72lPkS53TNDcQ3qJSZy+9I8W0VdQ9qXSsrOLTC4q0gTtYHHzEwguCL7cmxjG
         TDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432993; x=1776037793;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUZVBN2VN4vnEw4Br5X4PEYZMIf8IsAQPOGK1gD3tCE=;
        b=GOemD6dC3VfzN0RC3FBCZpNy2n0vzdJ2atjw58KASld7GwUNMDV3UhcxSyk5OB+8/k
         SsYIsyTFSzgsT9AYliRB82iTmGWoV3J6kOslxb+jONWao2VfuHuDc5GaQ3+okITpmJs+
         o+azhjKjZLfBTRtQRXuK8IpnKbA47rAhwcBhUhSguMcx+nMlKkaiLIZJGO5NXGCpgmtQ
         F4ErY5h0fJi1NakzqQAS3twRdvnDHpzxej/dJCGGbgm6J49F/LRXOwo8GvXaxIriy6Jg
         OCdz5qKPRszz57Xdd8grxhRkiYb56ZblSKxB5XFDf4tujQL+fg3uFu7r5A2m7+UrH9dH
         Axyw==
X-Forwarded-Encrypted: i=1; AJvYcCUyxijEppW+rTsJp+J66noqEe8PAo82JZgoF9xKAkdllHnwlLcXXXo1b7oCw2kUQ/kX9Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SOqyaUrWfl2hzZuakmvtaGzihy6j2Ew1ZD7ATfzxQ0WgaiSA
	lrTPZb+MTpqTI0FOAwr/e47noAWVdysZwr3naWKRK/dE3lDA3ciOqq1+iOL4+6uWw4g=
X-Gm-Gg: AeBDiesnNtyXQf/FaVlfpL8H0Tw4pgda2bsq6x7cZ/h1erM0vTwnNOS1H6RRMt5ZABC
	4aDN0IaD7LiCRd/QKChIO0srHX408kpASwFCfdYRnLRWByOuh8AHgfbas19IldFmGocHToitJLH
	JsQhHLBgINQ2C9FKdDMBTXGSb7qc+G7xhFBkrErf6iAfcNDcEXzy49zhA+PC65Puwa1swava4DT
	nBJSPUDbZ/ErIIC/XtCuCsxqTdfS/tSJxwYStDDoawdWNITXYxbFYISW4pC9quI5pfUEripBVaw
	CIpnhz0oiIaUVyZhZM4m+RVzEhWmqUPV3DGCETuCFZlg6XyFUzd7UG00q2GHLrpkUtODP795h+g
	ZHfmewAltod2zArNjXgk/RcUJ3BDSekGOqEHF8HOjL/dJotPntOItzLE9/4unKY3zDj63Q61dH0
	Fhp7ZvWqM=
X-Received: by 2002:a17:90a:d403:b0:359:3426:c60a with SMTP id 98e67ed59e1d1-35de67da841mr9588504a91.4.1775432993231;
        Sun, 05 Apr 2026 16:49:53 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm21338044a91.10.2026.04.05.16.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 16:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 19:49:51 -0400
Message-Id: <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
Cc: "Quan Sun" <2022090917019@std.uestc.edu.cn>, "Yinhao Hu"
 <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>, "Dongliang Mu"
 <dzm91@hust.edu.cn>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260404141010.247536-1-jiayuan.chen@linux.dev>

On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
> When a BPF sock_ops program reads ctx->sk with dst_reg =3D=3D src_reg
> (e.g., r1 =3D *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
> fails to zero the destination register in the is_fullsock =3D=3D 0 path.
>
> The macro saves/restores a temporary register and checks is_fullsock.
> When is_fullsock =3D=3D 0 (e.g., TCP_NEW_SYN_RECV state with a request_so=
ck),
> it should set dst_reg =3D 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NUL=
L
> type is correct at runtime. Instead, dst_reg retains the original ctx
> pointer, which passes subsequent NULL checks and can be used as a bogus
> socket pointer, leading to stack-out-of-bounds access in helpers like
> bpf_skc_to_tcp6_sock().
>
> Fix by:
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
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This patch only seems to fix the problem when dst_reg =3D=3D src_reg.
Why is this not an issue when is_fullsock =3D=3D 0, but dst_reg !=3D src_re=
g?
In that case the dst_reg is unmodified by the whole macro but is still
marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
a test case for is_fullsock =3D=3D 0 but dst_reg !=3D src_reg in patch 2?

> ---
> Apologies for the Easter timing!
> ---
>  net/core/filter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..8fee00e6adef4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10618,10 +10618,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>  				      si->dst_reg, si->src_reg,		      \
>  				      offsetof(struct bpf_sock_ops_kern, sk));\
>  		if (si->dst_reg =3D=3D si->src_reg)	{			      \
> -			*insn++ =3D BPF_JMP_A(1);				      \
> +			*insn++ =3D BPF_JMP_A(2);				      \
>  			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \
>  		}							      \
>  	} while (0)
> =20

