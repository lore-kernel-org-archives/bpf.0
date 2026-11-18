Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795016034;
	b=jWYaOaDkbcmIYbfPxuN8c2H+ZSocMCCf71LwvQWvw+M2tv7QCtGoUSFKP9SYQl+QWaUr
	 MJBbPJfradbJ0XIdwd3UFyRAGYc9IBsqfir8kpy5SvcWP5bDuPea1WHTDr9NAFTgv0+wT
	 0fx38F/IwgZl5cgEBH18bdzryVh/Wo+t5/oKbXb+bGX+Tz+y1qyF4o163QzULEkJavt17
	 da2hMHX73uz+RbTQGGCQ9eovxkhjGw4jOWEXFjfLqrp3Z3qnQQAU3vTAI2XGfUYqsVbSI
	 g8FGTaeVttexZyuVGfSkrbEA4bIh0cbt21FcSY5IzVZZ/hzWOEyY7vmOTjNCfGn0Gbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lWrCVJWLesJnIcVUok2QlZd+ly33TndKetEhrY+zgk4=;
	b=RSsffBJwjdJnOro+Clh5uuDSp6b6BsCeetPygZnlg2mGYS56E79enuwJ5XAUwXgkd9K2
	 1TTXd1T97kC6dgMyjkbM5iSGPowi9yIZg+XrPEgcvZlhRPqjyRP7NLS9WozZ0J6NQQueB
	 H+XPgyLfUktcNgvm8OjgyVaxHxbu94Kc5NAqIY20JHCe8+HYZNT8EBj7/zrMWRSkYnu9y
	 zF2CT8ssaEvyRz5cQlZDzw+HF0A6vhAHsWndnwRH1oZB9arFx9HHN6UIGKm0KIQ6Tk1Wo
	 0R693MfMlrDVi/RLUkYtloqWSC2ANzVYvA9PYxjSLFkHgaUpzEv6FtmtpjXHDEr5jFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TVXTjvFP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D760A2600
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 15:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF1D760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TVXTjvFP
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1bfd1373so4948851fa.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 07:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795016032; cv=none;
        d=google.com; s=arc-20260327;
        b=RQxlnIuLDXCo3hFatz8ochwlmwU1DGVfdHU1P5sHOIlr1W4dnBLXEjiWf1LRz0hJ2R
         s9y9TKYU6LhIpwpcsbcHTQOni9vAay6QBr3vDlh0ZwftP/lSM7q5AEP1PPmptaz3m3lq
         YWv33uNf1p3Rut1sccMQ4F5pQRGGulNFyrxpq2UWHRUo80WkmG+nAVm0Zk9b1Dnnp7SO
         QK2pqlVSD2qiMUjN92Ye1hsWnGfiV5PuVufywdOSKdVZdRd1/7fh4jX/eWibRkJTSSJw
         7PbK7WPZXIe/FpwpIfpwtVtwhvtPSo46z+oXYpJQucBFT246J0ZfFRpp+6/bImn6gjTG
         V3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lWrCVJWLesJnIcVUok2QlZd+ly33TndKetEhrY+zgk4=;
        fh=d1WB7SyOgmIXVjCPh1Ai6hCN2eBN34cTHH1JVEpG19U=;
        b=pWnAV3NoEDR4Yv5HpasSsNg723FMhEo1/aS6POPNHlhZod2QvTgndfmEORnottSIb9
         oR/tawuONJ/IkERmRU45Uzoo4X/+a7cF2BAvHu7e0bArzIILYyR2dB1uz2VH4Z/BmTVY
         aAGV2ulPvE2gRYuE8aNlzxz1ybb16bji78L8Vf4y3UcWGz2oIUzjk0OLRSCoVNzgvsZ/
         GEkY49ka6IYIZgSlTk7rujurqC92AQA0pke3WBd04rM0pjVAqoL//4tjwq2ee/T+i6zs
         vCabQ5b23IkGst3mVezGmX9HghzlBYC5MroN7EQYWalXQFbKDqVUhCNviBXf6lmsRCHW
         ONOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016032; x=1795620832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lWrCVJWLesJnIcVUok2QlZd+ly33TndKetEhrY+zgk4=;
        b=TVXTjvFPXhzc/bLEx+ZoM6GYbNLHu0lXds4uZhiPohiurv43e2An51C/moLDZn6r6p
         j3dJb1dPwshv3xWv43juKXtN4ffDqcgfrVWnA3rozDpb9p+Yu/25cE2FwpGjOjelZj8x
         7ri4xTBUOyO+x4rYdHCFN8/EcBNmL2FX85iQTCkIc/1RYmvMbHPPDHw8UFiffINAIMNr
         kSy2zo5qljS4cqeNaGTla4fgwYX12ykGsocfKTdllG2dD5hxX4J/Ip3Kz8ONcd5O3bFV
         ByBMEH5LorYevTS1+th5TTWR30f/G+ClveLX1sLMV2CSLC1igIvViMFEunbJH0N6R39k
         v/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016032; x=1795620832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWrCVJWLesJnIcVUok2QlZd+ly33TndKetEhrY+zgk4=;
        b=1ZDhwnXNMHQDrW8OF7z7KLpTl/HfZY7vikMBUNQVk2VwvB4SQnAUTKTsqurgqvmrGF
         k9h2lVT2Ke50260i0EvauzPPSLpNKHWvGIOvV8StFoSEP1YPdaYN86BzxH9dQITN9Hj5
         0K0t3VZeQyK1JWr0qdZbU5Y/8xeUfH/tPj13agaj7LbhvsYNgBE+yvQ7qPfcK99lPV7H
         9D/pGpnmRpnuxasWbj1kWnNeJFGyIdkQsDpv0t+zXt4lfnn1QO07srEFu+e4dTvW5SJK
         4p+zk8R8WZYqUXmnxl855ELnO7X8ZOtBaz4OhmEELln9XkorLeiRwiOMjFLCTqBe40Lo
         jhFA==
X-Forwarded-Encrypted: i=1; AL+hErEh7sPEsRCxlLoiCDOEjedSg0rxq+8Um6tojCdzHWW3yYeKfcrN1wdFMGu7uiE9UvQnf98=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LQZtc5l8DUco3MZX74Vel1ij+KtC55NF3xBZxG3Y83qbmvEwt
	1z/m2Hgn5glr+z1QsPQswWT4CDsJQsaEDtznns9A5mBv2bfcJ4Za+i2UHpMj/JwBc0T3jZ+oj5x
	nu2eZyL2y9c8LeSJisSwX8TS28zb+x60=
X-Gm-Gg: AYBFou2s3dKfqS2Cx2CNlVaNWJSNCJ+xx0pe98suBK0Kk0ipOHeLR6JGwTaixAjAUMH
	kgRNSUUt36Gq0QdiKHo4na8KhjEyHqmnnzANbOOZ1wUm2ldCjSgF4MMnfFAkOD+n+H8cElj/Lkp
	waS2OwTgn8EhnXYktyj7FU+BKOk0+ScKs36kS/eYJL6YHnqsXI4R0zNhx5BL6uAHjdE+PUBQWoc
	QrKSDb1l1/U5YzfNT5tv3n78BoHlL7gr0+sUx56MfKG5wW26uSrKkZyI/mSikdw44Y6zXgEx3s7
	lrpGww8xkqn3yAt8M4UKIuOJqEib0+d9xsJUKkzLm7Tx50wMI3Bf7BPnJO3ofoSzLjfHgTw9DU7
	ZXvRRNSy2Qu7EKw7YukAHOftfOew5Sy0waDPwG6g=
X-Received: by 2002:a05:6512:10d4:b0:5bf:a12b:9ba8 with SMTP id
 2adb3069b0e04-5c1aa2a82b2mr954623e87.65.1795016031617; Wed, 18 Nov 2026
 07:33:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115152408.48205-1-shlomojune6@gmail.com> <179492922969.3136.7887984434455212903@kernel.org>
In-Reply-To: <179492922969.3136.7887984434455212903@kernel.org>
From: J4f J4f <shlomojune6@gmail.com>
Date: Wed, 18 Nov 2026 23:33:39 +0800
X-Gm-Features: AclHuK_34vwhIVJ-WP0ppE9rmwaXeEQwWTV-oztY6Pf9rWosEEVQnDoBmiUwEAo
Message-ID: <CAE_Lbw=mYME61mRgAJFh1CArWPwL34yUyJGPrBkrpgk9VPxchg@mail.gmail.com>
Subject: Re: [PATCH v1] net: sock_reuseport: check program type on the
 migration path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org, 
	kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, audit@example.invalid
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 at 23:27, <netdev-bot+sashiko@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] net: sock_reuseport: placeholder Signed-off-by trailer in commit
>   message
> - [Low] The commit message says loading a BPF_PROG_TYPE_SOCKET_FILTER
>   program with expected_attach_type=3DBPF_SK_REUSEPORT_SELECT_OR_MIGRATE=
=E2=80=A6
>
> --
>
> net: sock_reuseport: check program type on the migration path
>
> This commit makes reuseport_migrate_sock() and reuseport_stop_listen_sock=
()
> treat a reuseport program as migration capable only when its type is
> BPF_PROG_TYPE_SK_REUSEPORT. Checking expected_attach_type alone allowed a
> SOCKET_FILTER program to run with a struct sk_reuseport_kern context.
>
> > A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> > expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> > attached to a SO_REUSEPORT TCP group; both steps are allowed without
> > CAP_BPF.
>
> [Severity: Low]
> Is "both steps are allowed without CAP_BPF" accurate for a default
> configuration?
>
> In bpf_prog_load() in kernel/bpf/syscall.c, this check runs before the
> SOCKET_FILTER/CGROUP_SKB exemption for unprivileged loads:
>
> kernel/bpf/syscall.c:bpf_prog_load() {
>     ...
>         if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
>                 goto put_token;
>     ...
> }
>
> The sysctl starts at 2 when CONFIG_BPF_UNPRIV_DEFAULT_OFF is enabled:
>
> int sysctl_unprivileged_bpf_disabled __read_mostly =3D
>         IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
>
> That Kconfig option is "default y" in kernel/bpf/Kconfig. So on a default
> kernel, a task without CAP_BPF (or a BPF token granting it) can't load th=
e
> socket filter in the first place. Unprivileged users can only reach the
> out-of-bounds access when kernel.unprivileged_bpf_disabled has been set
> to 0.
>
> Could the commit message mention that the unprivileged case depends on
> this sysctl? That would help backporters and security triage judge the
> exposure. The code change itself is not affected by this.
>
> [Severity: High]
> The author and Signed-off-by trailer both use the identity
> Linux kernel audit <audit@example.invalid>. That isn't a person, and
> the .invalid TLD is reserved (RFC 2606), so the address can never
> receive mail.
>
> Signed-off-by is the Developer's Certificate of Origin described in
> Documentation/process/submitting-patches.rst. It certifies that a
> specific person wrote the change or has the right to pass it on under
> the kernel's license. A placeholder identity can't make that
> certification. Nobody can be reached at this address if questions
> about the patch come up later, so this can't be applied as is.
>
> Could you resend with the author and Signed-off-by set to your real
> name and a working email address? If you're forwarding a change
> written by someone else, it needs the original author's sign-off
> followed by your own. The code change itself is not affected by this.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261115152408.48205-1-shlomojune6%40gmail.com

Will fix it.

pw-bot: cr
