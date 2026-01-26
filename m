Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B331338593
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434010; cv=pass; b=E+6PsVKuAkEedq/4/ZIf+4uRYSjvDqLuDBJcB+2kJbbk4zGgWDuTTtmg6wyjO7oFXp0IvoMtzPkoSdkw8KrwfO2r/uMvJqUidfi5g4DGoMsGnrEI1CwptmNL4w8vJq+po1NAH27rU4noshjTjIby1LQuRU3G0/JMn8WkEoIDOWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434010; c=relaxed/simple;
	bh=BX64JmH75Zpil8XSGmc7fuBqvPJ74wuAVwHgMmKcf9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxsHmq2lF0o9zg8pKsMsHmWrp5m9qJtByEbjn/xr5V3IRy1draUgcuwhOCKN2OiOTeTGSkrml5TlW8YcXJ/QnO3aCtMxYW3+wwzWB03Lx/OBC0GIA1merNmFyVtZbZsccKnsZZyBUIzPy16vKQemdglYrPUKmneJ5oweJFokvAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDGEanDv; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDGEanDv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-501c6665144so46053451cf.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 05:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769434007; cv=none;
        d=google.com; s=arc-20240605;
        b=OLwB1872AxejFGo1Jj8qexnc7dsNX+ubNy0z4MlE3IeH4ZYBIcNoMuCFne7iZ05h8e
         uhheArcuvSebMzPOmNkpOw0lOglurOXTay0NlmkZQehORvg5f0QPIOXfisQ3kRtJYwN2
         aTkIThwZYi0tPlW2RgJyqTOmaI09c6MdedczqAKhJ84K/jiHZDLq6bHK/cAxa4FXAhTk
         FgTrh18zGxHlWn4PXrqYkA5+ZUr4ty8lR6oKsWv2PMUHKtVpAq0RJ7hG1MsyHI97Jym1
         x7AIoZQPwnc89JKXxE++OOaBGcBlXF61E4k0zlCSKQP2m9V3eFwaIrBE6jrvt7cm+aCk
         w09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        fh=nxItD0N5JQfGRoowsL1nPH6+QNnFK4e6K2V0aidOjps=;
        b=L5ZbhFF2y3ufUrmEpV6tEdS5hdWgGMqjVttKDbZotA12CPqDtiGac2lpv7IvA+uFZ6
         qyMQpnCR1aHEiZE/UcrnXP1xLJ5Xv0dWzYRv/fVZRk/Us/3tQnTxdzP63jSQFX7k3ci1
         FiY6zl2fhM2xCjSX6lF6GbIS5Et+DVV4tKdEIcAZ5oSoTu48x3awCg/8zfcMHw9Tkkw1
         f5jYunFXXo+bEH7B1eJXw1Es8PeI5izYwxRi/ORHG5hW7tCRBWz8Ttpb2/5oGrllo/4w
         R/Ma2SEntFZ0wFuFSVeIP/ZMd5Hbn3ZkrPgJ1pRGWtTeKclPZzbYE1u1oBeb8smwGHvC
         nduA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769434007; x=1770038807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        b=EDGEanDvNT4Wyn5nIPReezRhtmbEaUy+2Cyq7Ej3ujlYF0qm2mEejLjFL4B4LeRMON
         3GUkp7Zv6bIf4Q1vLzRliQwcrSDmeri0HkUbm/By3ksTj0/P4HrUP5J++QxQDDEucda7
         DaoxAfh2jY144BdiuSGkPhF+TNi+UOcioJnqiKIIdAQFTPBe1cd+e0o4n+Cx/GQPXCXJ
         7XQ9xdLCaaRGjZSumtGiOOvEBVPiua5g1yqI1xW7JPFTvJjqjawcsa3urPE8TDEHuXF7
         zB3Rwn/OwPLcr/219M5tvhRc5c3CanQnqqb+Jg+WV+TvVKTLyEbjOrqp7dL/6EXVHu62
         d5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434007; x=1770038807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        b=S9peKorM9RxLnjVS9XbeL0QnK0w+T48UNKWP234QiIBF8ZffoLNkaH/onIhDepV26M
         nZwDYSsZi4JzwIjtFJaOU0xyWKkBJtxejuniTJ8cZibt2vH5sAVMCLHtuRDHdTWq/Adz
         8t1sIOwKgpjIQXSvP+dYq3EBO9UX8pemSZbC7bze3wpXE8zRRcbZCHyuHRfZiSYSvqJx
         mYub6/BnOStjbzrxCwS9L2nZiHFuAWXRUhWgzR8B94T0L5AillnqMTlvZG/7bWNWD8+F
         WnJmpHb4mLWW/XPV4lifXLnUcNmdCPt6BQ2C16hFoCIAgCxroeZNooqO/FKM42G6a7Ba
         /+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWnOIf4jXtYolp+W/NU/G5u1OTa7G0xk/10vU3KTH89JBPso3kuvpOzewRjQh8KE3Ae/uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOyQaMwjOqBQnYPOvwVnHdJZn2MlcFbJvSMIJP52ooUGgxVUWm
	Hpj3dHXgFol2wvm9dB4pzJSrUE1lsDChbfj5JoyBsiSHsEVex2yJhewA4QM/v7Ti1sAKi7/4+oK
	Iw1iuMEAJXhJrdcGJJK6curM+reFJ0XZrBg975IHi
X-Gm-Gg: AZuq6aLWlA9ZSDpUaiesDbAm7BWax8yDfWsqllyjTAGv/D940SuQKteszPON1BFXnMm
	prHo/+w+UYAk3gk1OJGqMeubHN5TveUt1iOmuW0G2nVW8QedFUWU8tKFCnq7+74SLuqFnwyB0Hx
	BRMJCecOftj3t50kBPCHZbUST7f9+o+M+QcxmCv0mmpgt/8k8VWdffragMV+QxsY2ZM/w6+Or+b
	KY30EPY6xOr1Krogp7L4AWSkr7i31EA3py1+kcctbR4+6+d5PFw1+o1C89vAbx2eX5IjuT2i39+
	7wq/
X-Received: by 2002:a05:622a:345:b0:4f4:d298:b47c with SMTP id
 d75a77b69052e-50314bde895mr44108571cf.28.1769434006965; Mon, 26 Jan 2026
 05:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6954bc70.050a0220.a1b6.0310.GAE@google.com> <20260126114332.23955-1-sohammetha01@gmail.com>
In-Reply-To: <20260126114332.23955-1-sohammetha01@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 14:26:35 +0100
X-Gm-Features: AZwV_QhmxFYxmShT5gsyJQWDXcDKCuEtSOICrxjGxqht-VPWWCf8urrICQPg7c4
Message-ID: <CANn89i+txkMjnxtaXtFJucNCLehhOdCw=5KBGpxCMj2v2erLNQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: fix uninitialized memory use in pskb_expand_head()
To: Soham Metha <sohammetha01@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, 
	Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:22=E2=80=AFPM Soham Metha <sohammetha01@gmail.com=
> wrote:
>
> pskb_expand_head() allocates a new skb data buffer using
> kmalloc_reserve(), which does not initialize memory. skb helpers may
> later copy or move padding bytes from the buffer.
>
> Initialize the newly allocated skb buffer to avoid propagating
> uninitialized memory.
>
> Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D619b9ef527f510a57cfc
> Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>
> ---
>
> v2:
> - No code changes
> - Resent to netdev list
> - Added Closes tag
> - Added Tested-by tag
>
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a56133902c0d..b0f0d3a0310b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2282,6 +2282,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead=
, int ntail,
>         data =3D kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
>         if (!data)
>                 goto nodata;
> +
> +       memset(data, 0, size);
> +
>


Certainly not.

You might wonder why we have GFP_ZERO ?

Answer : we do not generally want to pay the price of zeroing memory
_unless_ absolutely needed.

Fix the caller instead, ie root-cause the issue, thank you
