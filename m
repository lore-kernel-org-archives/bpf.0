Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D64357CFC
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765511; cv=pass; b=iob49PoI0AosJfwc/eyl7ddWMVu/iVqk4Zw3oYs99+lizV6gjVdhaC+Bj9YxjFe39TIFzU8lJYhjWUdogHoy6angP5nlMoZ1fQl6Sivbs0LurlnlCYujczylkXPgooc4OHI7bnryLZCDo8Wy8mNGzJQ0Hus3g8Y+zH+po/GHbWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765511; c=relaxed/simple;
	bh=xvQlLrP9VZeFA4X51ntM8S07ewhUqvCn5cruzlZ0VS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDYXbexTrJUDcIX+bE0QMDvwCrJRX4dvNGKSL+uaXxL9tKz7N/vSsyCrO0euNoi0gtmA9mmHio8i7qEbCm76xnd3fUI+hIuiON95ybbobW72G/DIhVHKCrNb/hV6GbKy0lUF1ZTzw1I9qFXl+cx//RqzcHB9t9F9pPemyzIBZUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b68vdhGZ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b68vdhGZ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so6687351cf.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 10:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765497; cv=none;
        d=google.com; s=arc-20260327;
        b=s9OkKvQ3I6kKu+jBMsRuAl8NdfYhuciVs/OGdBR2yvBQFP79AyIM29AWrNqo8pr3rq
         i96BJv+3WlJ7j5Hf/Jovybwpw2V8h7S5XcGgn79DjtIzIi4/LYBd0ZZr6JTGz5tFxVnB
         SJ9BMRvI+K0/I0a6CtIox6r9P+C5jntxjoKUFkWZ1fEHtF0+JMCaYCsLn58lFGYPkY0u
         RIXHfQhC1hhZxtobyfJ6gVLuZiyBfPwFml+bI1x+QnaiGzHW9DmdIB75ua5oGyrldrlH
         B0XWQ0ZfSYDIyLb2uRfyabWNKiiDkJ6tZca8Wlrev2PhsqEVPUzTl8/lE1V7uDM/JuYZ
         8cMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        fh=hTQ4aD0YVTfL7GdoqLpiDOtgnWMjUl6pmM8SUA72zYw=;
        b=UrKMO2SMc4M2Jz9yU3+Jh09R1HMUquJhQk/fobGYZsec0AHi14kr1fC5Kcp7j11+eG
         Co5xzIxOHAI5gKMWml4kDdl4O+hUvvSE1Rw3o1Nmuyr//8YZW03ZlTFlgoVWTrbvQatT
         J6kNnsQrKa7tzzpde/LEWMPfvx2WuOHrBt8oj4eqAkuAUsfvJhFiztXr76/UOmw9Ku1r
         m3zNiqqtY8BbWbCywGpje1wCYc3Uq604SuDQKaaiYaumcJQuun9xDVceKuT3dYec6SNX
         bakJFb7qi8GhOqRGCmVsrD1jlpbNZyA9mTw2RsAZrt+7XKIOAtYYwa6NpxBl/wpC983r
         ByOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765497; x=1788370297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=b68vdhGZgBqiRqH+9o7YVSMh8DtrwpzcwpovG91VcybnYoOwQrpqPiS91LIp0YEKwb
         JB57gPOmCxXA5wrW4ACQdxIk6cgiMRKRxK/BPeb9Z0OzjVEaKZpjJyLytaHkIDNYhjea
         niHSz1iquDjz1vdhnwlE4SM6P9G0YgnvyxWKY0rUvBru4LsvJ5jXLi7D8T2eJnV7ri73
         aM3b/1FWKTekqo+3gmXuc/Cw7xHEfT4ErGKqYqg+lPMyb7pIf7MMWgwA8Mxwr4d2rYPD
         uAsqhht7lAx9tqCUHEGdI4/cgGjoP9Q2Ah/D80KxM6g3wXN4Qaqh6WQR3ujaxU+AS50A
         IaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765497; x=1788370297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=kkvS4v8On1WNP5Y0zkwfhjGdIaJ4UbLJrKZTCGezQ8xjO8HTOZNq0nz5g0GLNIl6Ut
         36PdykRkUBOp3yqcBmlNUx3mk1T5YtqKiMcjiDYcbbz+1Dzj5odv40VGJFNRTCdlNije
         73XPZPK8TWb4QHKcNglieBt9HZSBYr6BvK1YDAJ8/I/ir0Cx4sFiov5GBoXWxBeICO/+
         f5+w0wHX/ReZEhtH76dBh+K3I716HfsQkJZFkGrHq7t/GeSXR9UQUzHMiapZrJY55ao6
         TOZpv4ORHD2GxEj7YVBYWnTA49m4HbiN2gvV3NyR81Bxm0vn4JOvYNpGIzG/hNuXbQMC
         3pww==
X-Forwarded-Encrypted: i=1; AHgh+RrkC03Ge9atu8Z2sWUKjUiF11GURaxqPWMSWM1UgGggOhUTIRMmotk9cHtA7MLFtl2Fpek=@vger.kernel.org
X-Gm-Message-State: AFuF++kjgYObknTYnJFVo61YInLzi+RDqFP78CAUSC5DJiORe3DjK7gQ
	oFl2vgByzdLp8D7TLdF2Y/0z1uu92IMJCPjZ3Xpo3PxhWSM96bPrQi2XYJgijiFRK65TKYUjjB7
	OGNiP/gr4VEznXavTweZg9oy4FCGUCu0UsSWEojaf
X-Gm-Gg: AR+sD12b3T7/M5C0cpIJ360o1WMkEUMvZI2DAJVwX9kYK43hzRFoVPM7cR2kkvJvG0z
	K7YRI5aAZVMoXzDe0D9AYvlJ3TFwbBlAmCvsGVCq7UfD2V1zS1Lr+7aY2fEtH2e40GOcpbOQYxC
	Vl9LXMZDuYGU5u1B8tinxq/rJtZfKiSF5pZD1WF5ysqHAWZv3OpGoEFDxFz5iUEQ1/oaKcwBY4f
	onuzMHlOqAcu4CRZ2IahCaNhbhcDzYc+C7NfGp+S77BmUOnZ2+0el9VG0Ax/OOpcyMdWy0xxd57
	xLo2j0yRAmWy3MH6TC6Hv8BINalzWkMuk5c69/6cWrUs63kdBayMEw771x8/x16l3Rf/Nc+4jiW
	6+gDChJ1XKE5ERj26Z3k1tKwXoQHpBUl9pGRlmDb0XJ0M+gCHQ92oU90nNhQ=
X-Received: by 2002:a05:620a:2584:b0:934:9639:3a4 with SMTP id
 af79cd13be357-93780439e3fmr788607485a.41.1787765495949; Wed, 26 Aug 2026
 10:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-3-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:31:24 +0200
X-Gm-Features: AcwNN1W2Vlibp4Upi6ckUE2YnF-7NI1e62marZLJ6U_CKljSBV7tC__IgHY39vw
Message-ID: <CANn89iK9NyWmpuE8QM5W_t3MK30GZf_Wgbr+JsUVARnXZBgN6Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
> the icsk_ca_ops pointer.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
