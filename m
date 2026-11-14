Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699106;
	b=gGfc4SjFPQ9gB4erc/KTp0PTXCVVoikLO2tgeJsw2i1eqOQGTLAVgsucetgaftWDou+y
	 hg3BQd6wyMOzyJwON2II2FTv4zmgNggP2mQycTf1WdWKV9UX4J7o92u1mOZ5v8QCM7eQd
	 Wg5ZuxkS8ZY5N0KUNxlJetzCnse5IgrpLBh3NMXUw8N6Ip72vjovtd0chS1fqMs07x0fm
	 NbXd3fEPUk4uPyaljw+iuUD8rc1DROPB+koVVUtbyKiGY04kY/jaTKmS5375CW6Z5oJYd
	 uKaPA/ILG+NO9qnc9PT8aQlqcVkkDL5vQ2nM6iTfoh1gZbSKpHr/eti2LJ8bJmz7mfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=FuLBQqnBbvoK3ewsORy4ADoj9MqO3Z5oxDcwnQE1DVg=;
	b=o1o3tYSGMGlf1d5qntPVIwt9dd0kGabYTkfRqmXASMmBOnSMufLFji0PvdGNqB/pS6Zx
	 XgCEmSpo5LsMVUcOoFmUv+w2qlgYwEAmIV9rgB2vxF2tvUeF+mrOTDx12wKRwtQWl9SQZ
	 m3eFoH3knu4LSuiKb6dE40eSldsAfB72F3hKAurOk3xxac2xSFah527MWTD7LxMQIeXpK
	 8ltVmYQ3uQtuA/Q+xhad8thwtnu3vP94Pjuna9/Ogw/yDoHdCgaHOcE+LkxnQ4lgEtZv2
	 7d0wY937CoGhHfSvBfA28TP1AkgRbSJWk455dl6aResarGuRs3UKDdLexayiAt9jgwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0Buc87+;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F864606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 23:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F864606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0Buc87+
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1871435a12.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699105; x=1795303905; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FuLBQqnBbvoK3ewsORy4ADoj9MqO3Z5oxDcwnQE1DVg=;
        b=N0Buc87+P6MRR6zruckjy9JLGrU2vbSM1hsCB1F7XnlQCxqqSFB4I0Z877rdMLRcly
         q7QF/fznac6aEsUbPPpPobzf/aTa2SnEI6ygFy8KU87og4i2YfGuOzCUsGdRoqrGmSxZ
         fIe6EGqBH873sZw9WPRc3u3a/R5R5sJbth8VtGTz7JCb40vS+AlzW55/2O417a7Cm5S+
         jxRjgisz3NoV+bEg5/O7n0w+tAKf4CQnpLioN8wjOxaKnTVvDWX6m0fhKM8fe4Wvf72w
         8SPIqWZf/0mNRNnl7HX77ChOKf1e4ZqM6jvMLp87gqsMwqxwMwqMYBs1tvnF6hIHDscv
         booQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699105; x=1795303905;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuLBQqnBbvoK3ewsORy4ADoj9MqO3Z5oxDcwnQE1DVg=;
        b=wIolmU7K0iHozya86Cfpt3/YFz+XHQKQddDCC3CSkOIyrQVHKJIf9oq0OyYEYLNH23
         npBI/aDSsXO8Kb4i3mNuqbanOpxSF0Wg68iR2908b6Hd1BEMcDP0kM+rP+zxaPiHWx9q
         Kza7/eR+ZoLoBpRlPpuj2J0kDhKIoD3ql0TVzvUc6ccVeX5B7l+427Y0StyT4I2bRpTg
         jU8z7L0Mqw5X/WpdFZRdUQqXvehtFVwyLczgEN5GchEv9QtBpk0QoTEwmv2+/3VdUfFi
         05VHl1hgIsHhj5Sev2mBSLiduhTR5BcB3LDAgd3U0HrlpO3Pu+7nleq4/Hmas9So6swm
         wmSg==
X-Gm-Message-State: APuU4Z8Y9rPCD2bOkXvVrD7JC7GxlhsN8rQQMMTTiLQX2qzTA54HsSW5
	Rio6dslaVFcvkUHzMmLRqej0Z3BgYZjABGL3dEKM/hCtjbHwpW+B7ho2
X-Gm-Gg: AYBFou1iyXL14bTMjlrba6DMfknu371xsreR2vecIlJoKK89JKqpUV2coIJHTUJjbKR
	hi/r8DdULGbHB6dFa1sbr+srLIp/l1ZznzWFNuTBOTB10HxGZwgdApY6alGD9Dx5l9YQZFKm+BO
	M/ssOUiHprEWmU6wz1vUVyRXkuub58jKZ5OMWaPMolUck/D74ibHJSpQZ4sav8xGUG/gnjgUfYw
	auXFEuQ56hjWIaWI4f5rzXRIByrif5gO0sqlQ9UpeDc+Xo8zHDajy7iwQLToKs42Jlz5x/SoV4x
	YMCVuUfLYeMoM2WxYLfqj1V9PqJxrrjKPx1OkmFYcSTkWGXir8ZzRIsil/gMWMszPSVdibp+JxH
	WQyHONT9d3E8hreA2W2H+D37lQN9a6/hQDfCkrctnL8QXLyc6Cds2TpRF0fKryG3dxwMyKZTINh
	jd+IcJfqjOY3231dR4QQ2rv3w9p3KQwPRtGbVNzuQNENV2Rm38akql0irg3Ujs+f5kCqWe8U/KW
	ZSEJzy3iQvV0sTVAAGx0ptiKybrLrQA2rME46hT6RZMKory6sF9P5AmwZ48T+2Rfy+/ORcv6H5F
	5Nxs87GJou3MZAFIjkrgSVcoB2IfeFzsx26Cs+B2GfIovKG5+1Eterps2BYSwm1Osdwwwf2dOFC
	HK+daHTFlbbAsWyHweFvGvv1HqUBRwzgPKg==
X-Received: by 2002:a17:90b:4e8f:b0:3b0:ce1c:e754 with SMTP id 98e67ed59e1d1-3b1b0b52de7mr6329703a91.62.1794699105516;
        Sat, 14 Nov 2026 15:31:45 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm9993379a91.3.2026.11.14.15.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 15:31:44 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 23:31:44 +0000
Message-Id: <DMVBQIN4TRA3.3Q23K4YDZMP1A@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions
 that return errors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
 <20261114051805.683966-6-alexei.starovoitov@gmail.com>
 <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
 <DMV78SSW0U92.LH9TAXR0MZ5O@gmail.com>
 <CAEXv5_hR=RNzwqYB=q=X_CiYSq6E2if6YaS1TiVU4LMvzfnmNA@mail.gmail.com>
In-Reply-To: <CAEXv5_hR=RNzwqYB=q=X_CiYSq6E2if6YaS1TiVU4LMvzfnmNA@mail.gmail.com>

On Sat Nov 14, 2026 at 9:07 PM UTC, David Windsor wrote:
> On Sat, Nov 14, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Nov 14, 2026 at 11:37 AM David Windsor <dwindsor@gmail.com> wrot=
e:
>> > Do we also need -EBUSY here as an exception? crypto_enqueue_request
>> > uses it to mean the request was queued on the backlog (not that it
>> > failed)
>>
>> Good point. -EBUSY is not a failure there, -ENOSPC is.
>> A prog that returns -EBUSY skips the list_add_tail().
>> crypto_wait_req() then waits for a completion that never comes.
>>
>> In most other functions -EBUSY is a plain failure, so means_failure()
>> can't drop it for all.
>> ccp_enqueue_cmd() and qat_alg_send_message_maybacklog() have such
>> a backlog too. All three also return -EINPROGRESS.
>> So drop -EBUSY only if the function returns -EINPROGRESS too.
>> crypto_enqueue_request() stays a target with -ENOSPC.
>>
>> Here is proposed follow up... other ideas?
>>
>
> Looks good, selftest looks right.

sent a follow up, since it's trivial and doesn't change fmodret list.

> Other interesting edge cases my bot identified:
>
> 1. bit_wait() in kernel/sched/wait_bit.c returns -EINTR to report the
> status of the waiting task, not to indicate failure
> 2. try_mem_charge_cg returns -ENOMEM, but callers might not be set up
> to handle it, it can be masked by __GFP_NOFAIL. Such callers won't
> expect an error there.

BTF can answer that, but I'm going to table that for now,
since chasing long tail is never going to end.
We're not aiming for 100% safety.

