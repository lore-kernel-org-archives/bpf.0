Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5364DDB4F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617392; cv=pass; b=RY16LLe4vAgS5CNCm+DU2LfwvXmPR/kGaBg4B37Yy1/djtaQB2p0N1bQIsVQIZme/iwj1FH8p00Os9vQjs5WY6stIpwtJPnxJ3ziCLVnAmqDvtp1VarUG4XsdzRi7enSzfg7xCthYhXZA/CDHpeo0ske7yvOW/6eezRzqruOfHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617392; c=relaxed/simple;
	bh=nxJChoBwmzTKXKMcM45VqLvl7ngasT8C9VAQle1AzbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlU0QfMA2Xc6MDyPepTovZ+Nu3sNUOsTGdHkIbPvNOY1MKuEAtcCkKGgjR2E/S0gOw4HdrjPZ2o85dDwN157awAIV5PELVfxvaeYZLhUtHqp5WUpdongug/H9AfjOE/dENDFfun9kcwx8Sh4FYHMnNMyFdpWF1ojOpHAlQ3dVFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRRCKHzT; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRRCKHzT"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4e4a4d77e5bso59950b6e.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617390; cv=none;
        d=google.com; s=arc-20260327;
        b=jJSjZ9uHvD6+auT+DKSMpiIzwKOqdKff/Qk+rAARbimts05HNCA1gLjSsmy8gp30BT
         NEsTNkVhcuWJ4NQKYXMXRCk6PyKj/GO4xnP8arViB3jZNXSytxNaryTJLEp6eE/F5Df6
         1hqhzFvBQzXK4cNDE6dJdyETQClIGpwC1TooLLnEb3ubTS4zj7jFmgFvwQ4twR8cd04w
         TF/Sk7bGmqW/C8/fbkFHWUcGgEH4rcIwjJp41gsYVbrLO58ZveaOzwXasuO6jQo8yEUp
         4igFistkHyFpC/I6R9A8KZdG2zyNaxntoyxmSsmgcL3gmjxhbmjpnIt/rdW51E/F880x
         Z5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oc7A63JbH+Ok4G4qh8iOnEvm8cBuU6WIcMJKCamJNmE=;
        fh=2MBOojPsOSARizhxuWgT5BqcaOh4dFXJJ9MmFSYnYEA=;
        b=mf6IO5Pnq43yPB73TxptDPwwJkWu8pRMTuRkdxSu7oiBntqO/7Q6uBLr16EoHW2h/C
         vRRElXRCmMiGZuJbNZMxDsuRpQSKMSvzxzCRPxf+MtWavM3v8vPkELWb3OIT/sfhCdHO
         xrzm1cuyEz/QqkuYPuYuFclOiEe+AemizNJBc0Uds0nUPBZ1ZMLpTUWQCmYo9afCcyR3
         a22GMY0sDiDMIsx8azBsY3XO8nR0Tl7ZPUTls8EtgcQ1IBFsONCgNWWLnABSCMObAhG2
         /O+5RdCmMOhVy/5ggFn4JEno9c9mML3n7zhurrtpOEqQ+H5tFW41kP8Vop3QILZx+srZ
         9TiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617390; x=1791222190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oc7A63JbH+Ok4G4qh8iOnEvm8cBuU6WIcMJKCamJNmE=;
        b=YRRCKHzTMcJb5I6d/CoVoWucmwYviDbq6O+GVSHjsXaAUsmNnGL/EmsaZZ4CfNVrak
         SbZXemH8ct/tFqhYv7S5Yf3rlL3jo/Swf30/N/d/WKXbZHCAlHBeDuBz3VG3U0w0piG9
         lqs0onFga0FSAyufON2nsmQ9+8TC+Csq6pg/45bPYRiZHiXNWAen5+tUWapcphQN6lfK
         T4zdBpdojLEuqxXMZBnVY2IDCGhzJbDiSiFzIAQq26+zaWB0Ifnj8rafWkpAVXA1hOyQ
         ErYZMEbsvsv3lcRkGn0KBIPprwi25FzLvHvUh116fp2mf/2ue7t6oh/TfMTiYbAZqadD
         6V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617390; x=1791222190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oc7A63JbH+Ok4G4qh8iOnEvm8cBuU6WIcMJKCamJNmE=;
        b=CeABS3nQTaeKaESh1GobXbHBcBHrRuIATeuN3nD8b7snJrr7Ke1n5VT0ZRQMQ4JFK7
         tgCJo6UrJ84TbtXDVFa1LOR4JdC3INqKTg2xgPzYczgO3euxZAQDIFDj+YT4GimvllZ9
         tTaKMpDZrb9AE1j5GCERbq9ydQRqkHrNtkI9N6fEK08CiUTNtrKT1ZfgsXWeCQFCkaYo
         ogh/d/kkVMZJB6XeUDNocSGRzDbCHdPHJ8u8dmjST5wVmyDY+Ji9a6Wla2zMVKi2Q5P3
         sHlrqJa6rdkOUUng+RyZL07oUQi7DVJYUQxZxJFD53GrtFnxThhkz83X/XfcyGGAjueM
         FjGQ==
X-Gm-Message-State: AFuF++n/pBohC6UPsgbd1wagrSYShBJ8QT3oFDeaZvRYDD46hn2dBvY2
	K1znWDn3H+O1IOLyhfpd5wPVyPI9sSNMkwh6a+/ePf8i4/WEjZ9HV6GEBN/2dIvAtgSnlgv9EJa
	NBAmzVX6/7Wjp0JPJTEz9k/hd6ZMBLXE=
X-Gm-Gg: AYBFou0unuWIm9zDht7jYEN4/0fk4TjEaNUojWZobOjSqkmhyBEy7ub6hiM9ljmdBcl
	etfgMXdfaio83wEFT2hoqnGkEuQ8q0mlZj4fbXUd+T8v4I1ytqOdHQFdX+9q0KLbtMZQe5U3Rp0
	PwwTpZqHZYJItKuxV7GnqTCPV94X0Ef2FMSRXS5e2OyuN9AtHE6jK15cZ2kFtiC5/OA1ipQS1KS
	J9Nsp63q5Jg4UqEnepD0XIQeFhCXZ4By/40p2PSpng2myeLrdjwcNi38mweQC7e1JuIdlZhGtCN
	8CHQ4Nm59cK0+yvWtDjrv8+fJesnq3Y5zSPJlxVXTyPqTtA7d5UMSf6jCQiICtrUuw==
X-Received: by 2002:a05:6808:181a:b0:4c7:26ee:3378 with SMTP id
 5614622812f47-4eddbc3ba35mr15582b6e.30.1790617390246; Mon, 28 Sep 2026
 10:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925211256.1834061-1-ameryhung@gmail.com> <20260925211256.1834061-2-ameryhung@gmail.com>
 <DLP49QC3FFYL.2255E96POZL9C@gmail.com>
In-Reply-To: <DLP49QC3FFYL.2255E96POZL9C@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 28 Sep 2026 10:42:59 -0700
X-Gm-Features: AclHuK8BLivePhDSsYjfAn4jkpryvtabC_Wif-yIcr6hBeIaS6k19lZbhX6VEiw
Message-ID: <CAMB2axMij6DbHMoGikb2pUeJF0s+s5q2yoJr64WzRE4JMUYUVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/12] bpf: Fix kfunc nullability diagnostics
 after wide arguments
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 02:12 PM Amery Hung <ameryhung@gmail.com> wrote:
> > -             arg_btf_id =3D btf_params(meta->func_proto)[arg_idx_from_=
argno(argno)].type;
> > +             arg_btf_id =3D btf_params(meta->func_proto)[arg].type;
>
> check_func_arg_release() and process_iter_arg() index the BTF params
> with arg_idx_from_argno(argno) too.
> For kfunc(struct two_u64 v, struct foo *p) 'p' is param 1 in slot 2.
> check_func_arg_release() reads btf_params()[2] past the end of
> the proto and process_iter_arg() passes 2 to btf_check_iter_arg().
> Let's fix all three in one go?

Sure. Will do.
