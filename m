Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C33B9920
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507533; cv=pass; b=VHjzsxSYr6p4Cs1VluMp486cTNLa/nBar8e9uKeh+8sjF44gM6dkUx52QrBvTZKXkHqEXm4AhgxtbvNn0jUQp/wenoNvb5UEDrWZ9rRBbX/4ZOssbnES4XuBqI5miJ4q7expEnaV78rGw9WVN13L+zLb9vjyMkb4l7wpYNwXwEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507533; c=relaxed/simple;
	bh=6xbLFFtqBJ01FSBulKyjDCamVJlD6Oqp5iYuAsl9x2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ+9FiAep+QV+iucRt3NLUQXiS0820e4gYXlxO1plA257vuhRFWFVC9rLnQ0Q7lPsDGSiNpTReOI3bIZ+iK5de7ojf2NHMzKbS9x7x1s5GqLCKg3IuY9s6kSvQIUrYKhXfaZvKKjctqYwIrgBriqtj/uVjBOXZ9FgRcA+/ffLJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toCfuY8t; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toCfuY8t"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1384ebe7a10so1950346c88.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782507532; cv=none;
        d=google.com; s=arc-20260327;
        b=rIik3ilg9mGPBtB4f9V3pBFS5V6JA47gSi1T3LllhMyvKTO3adDFQ/b7Ew/KqBCUDn
         ZruTw4H+rDYguFjuoIRIyT3ujBjvSIkzaYN5CC+r/cE7NPIQDbqmtzn54xwE5Da3gyS6
         LQSD2PBoKagT/LbrlqakMueRI2R9X75FK7iemD390sqpEEWCx+C1kDsJtyIRT22OPNG2
         KID9zuKRjWfQLMYEd9KEgcEJQXd8Sh06Q3HPRfnoGR1jp7Vbv5KPCqoD6R3cvhQLWBYH
         14flIrhrE5FnElLVhmIezI7J5vShd9/aeLq3FeeZB2izjphX4+sAZDY0Gw1Sp+VJSqFq
         g2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        fh=lOMWbeNzfiqoGa05u0KxyqvKFdmPLbzVTLPz9uvfok4=;
        b=s5CMfLY24H9Ey/i/R2P0MgseWEMnFVvDx1Ouy1K1mlCW8qWGViifmjq1LHteqCG+id
         wLnEhPHBLhaP0fv+QZuLctPjeyytUr/J3E5NkdwTxSqGI7ouyMFJkoSxoI9GvZ30jEK4
         A2o8vFPIXeVthycjszi2tEE0ObqdTnYtfps4eVXkde1RO3RhOPa9ylC8/lp1j8v2Q6P+
         qQUKqHAoqseGUP2GBbZQe7drysXUoOomVRg4dwicwQ43jerADNG4Ms6y+g4SLYCqKVHi
         oBDOdbTAj0cA4DtxiEPoNJuaViIAJG24RFIJlB42Y2JRo5iQ/4/5sxGfilry9rbuaEPz
         OuGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782507532; x=1783112332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        b=toCfuY8tnZglDXvHih+sU5z8TlaYroWWJlbxW4++Z4MzkWbG+wTTygYubM1KAnQa2D
         oGylxxSh9C/i/m1/dvgb1LlrViqqH4m+5VRV2Ac1jND+AYIUJWMTFlN5AjnaAm3bVPCF
         3DbQbQTlPxiOXx6MqGsRrvQM+RHAI4WRovF+fs/xtBYQOc+13EkHlx6c5CVeT7WkBMRy
         E37qErtYCVS+doAw+QJWCD4i82Bmh8C394EO6grp6J5jr8UmitsdYnyqS1q9fIQbVAuK
         ep9+WIwKZ+MmlxzQXGef5WYTLI9alqZL06BA5aRJCH9epgn8sS4DoqXgdKVjkISZD6q5
         E0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507532; x=1783112332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8WYF+0x5GNVnLrxh0pZVzPZyopUV+zJjv6tx8gPPi0=;
        b=Wm/WxfKSaMbIVvdRNBKGG46dTNdPuJ9/jmo2KXPyPWkQ7Cm6rcu1FMY6EPPfJJshq5
         Cr7lLNLAmLV9OmmGo3qpDJhG0Q1a+iiliBcvYo9f+FZGNDoUz1jAFEmgNA5WoIcidC4M
         ezVa/pqQ5MK+yR+h6l/xgvX/Y2XZDILhSKH5IVIaO3y2PL+h9DQXBAaurEDY/aUYcfjI
         MgclEOYAFW30SrcTMZHZE4lBwMYJJ/of5vWVoQpnU8S8wT7N0IkUH+jTHNWABhzxh29b
         IKrFj7Er7OGdiSxpacAyBmqgczbmEChOxxv49aWNvhpEP+FCDeNwB6ZwOdgFB0fq2DwB
         XgJg==
X-Forwarded-Encrypted: i=1; AFNElJ+1Laek6fcVxE186C8jyM6QvOQwtVcCI+/LiqclcTVSizXsxPJWdMf6myd4wH7KXmdmBCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaytN63cDK+b0vGRJDjmwf3+Uomi5gmiLvsdESmLU29miCirI1
	YzytQ69ePlqO3NzRhRvkBzqsXAlk1pQaMxHZG+AXyRTOc6YpC6O62I0QKIK3PhbIaqi8REyQbv+
	qdWfh0CYgPUmoXR5QmwlRsHhK6aLJzoaxqgKPKJid
X-Gm-Gg: AfdE7cmIe7KprvaTrmT+Qc0TMXsRDyVZEkC8NR7Dz0yPSzk4uVV09QGWyYn5n3iFCOH
	ibHub8MPY1ow8X8jnl1zsbY4DIZr9QT8nHq4URXIqoXCYmbyNXCblYUTfdf6rUgKTo49VKsj4Ys
	wf7+qkujY6y/ytJiNPoz2d1hWaI8RME9pt9wF9opMt2c9/r2IK3Sf7+UrSqV4MqFcSfkTTzF4Dt
	ltI0Db0zIpy3eeAuxK7mJAr5qFYR5mXvaCXCuFhQ2U+c6TI+8sOwKR60/n+X6kpItTa7ebQ/XHg
	ltpBvczLa5ZrRai/OzTpJEnZm7Y6VkOLlx1fQp6UODkrRm3sP+wEz2fXOOqMUUI61itjAUbNKsY
	ygDbQq+Dwowlj3mKjl90ligGxYcyEsujkFgbd6f8=
X-Received: by 2002:a05:7022:629b:b0:139:b63c:a0f2 with SMTP id
 a92af1059eb24-139dbb8bdb6mr5708446c88.33.1782507530580; Fri, 26 Jun 2026
 13:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:58:38 -0700
X-Gm-Features: AVVi8CeP2eiu_fzuvOztLhngiE1Tsu5qut2zHfev-g_7GKVOiJ1ehpzU4Kk_fcY
Message-ID: <CAAVpQUDULzZh58oKkRaYqgM9bRToGb7wHrzT+cZNpRmAtM12Ow@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error handling
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> Update sockmap_listen to accommodate the recent change in sockmap that
> rejects unbound UDP sockets.
>
> TCP: Reject unbound and bound (unless established or listening).
> UDP: Accept only bound sockets.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--=
------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index cc0c68bab907..6ee1bc6b3b23 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_lis=
ten *skel __always_unused,
>         errno =3D 0;
>         value =3D s;
>         err =3D bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
> -       if (sotype =3D=3D SOCK_STREAM) {
> -               if (!err || errno !=3D EOPNOTSUPP)
> -                       FAIL_ERRNO("map_update: expected EOPNOTSUPP");
> -       } else if (err)
> -               FAIL_ERRNO("map_update: expected success");

Initially I thought AF_UNIX still exercised this path but it was removed
in f3de1cf621f7.  The leftover in family_str() was a bit confusing, so plea=
se
follow up on bpf-next.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
