Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E23630B0
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732666; cv=pass; b=lQSeUCdMnhZNLO4R8z+w3SRNiVs1YkFEfuAuaCxaHjzISkiR6phhdRvbxl5O2uwXU699KRP1+GRsakzR+8/xWHBjikHBF7lDQX4XudLCKlQ1hxXnRwQz4BBJOOv47+0qSmVcIkVB/zPM/dgUDvceJk7DgJGcOmvwsuGLrHrH+TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732666; c=relaxed/simple;
	bh=+yTnC3qUCMhYF5izBj08k4AdSicm6irjFGKLdWdw5gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3GrrBW5AQ5hPZ1cJPJvZ4VXw/HEIu24IAPLmXPJiNQCB/LBk6+Ncq+lGYx5jv9fdhOf0O+YasUmEEVruen74YoXeRc5mnGt6trZrRD0de9eUqflO78Zu4Dbk0jeo2ZAEzYxgmF6g953b0/AdYj09f8anE24cmrWN2q39EhC6SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrZu+qdo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMua4GwG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrZu+qdo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMua4GwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786732664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
	b=hrZu+qdoz3Xn9mJSNltKFNpdHGMnq6olmPGRf4aELEhsFnGrW7xHZ6rqspnCW9wOyXStXC
	WN/MCTBGnklfTPNI5L02lycGCvPOS//UzyqZGzw22AY8VP6r5IJzqJ+mHVDs894vgxMwhh
	tr+ub+1uuAOWs2b3AH1+JnG2hEDBtPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-6pG_2lhQN5uV5YUqngX-SQ-1; Fri, 14 Aug 2026 14:37:42 -0400
X-MC-Unique: 6pG_2lhQN5uV5YUqngX-SQ-1
X-Mimecast-MFC-AGG-ID: 6pG_2lhQN5uV5YUqngX-SQ_1786732662
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c213d5fb55aso59297766b.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786732662; cv=none;
        d=google.com; s=arc-20260327;
        b=EQujECdTNiWF1tQbICRpr3SIIUyGkP6BX0gbqAee0vOho5N3D4b3aa6WeNLOGmzk82
         2jMZoiYcIF0PzUcEe8UVmvPiZFStPW9Jmhj3hF1XnLOdpnAMReYDK4LI/1eGSrGtkgT5
         YkY9t3bqKGXmRlCfLPd04sGUtR7nsbOONHr9Ur1dldG04/Cq7Qz8v3LDq80SnLgOLlLM
         qzpY4AYKKg6UrjpZypLuVco2gTRibIlQyibGS7qapADzPiz9UFQANb88J05HHkzw+zdj
         6ZlT8NKCUvvSm6eNCACD971G1hp+/RCHRJRhDa78R1Sb3nUSWtOZVQumlPxSG8nzjC5w
         fK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        fh=hNklfzVrNHnEtsLbG0WMixfNBlvuC7jP4mJ5Sz6ho7U=;
        b=lE2m40KrdV4Do3QOLuZZYSxEaIrH40kKGHpOM3i2GRqqdC0+XpGMtZW9iwKFp9Pk2s
         FpzsG6/0+bFLYACk2Z/N8Bk21XFWzLtWV94NJG08nMJwBugC7nyrvEck8oxlH8h++D5Z
         HQLVNWBRB2b7NmlCkSA14LWPhrMr02D3J9mZE5p7lNLhO9fr0HapSMTXVebuTrLBsCDY
         iiAwOq7S2ZbsPPmfq0S18sqgLPxfWk/sqbgmsGgkEQ05xOrma1/PfrMfhgau4CFP+wA1
         77mJq4Up/CP8e10sDpEr21GXiebSF6RnhYLEvxY/oUPteS/7QwULZIfujB9w1JBuhXdk
         hcoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786732661; x=1787337461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=IMua4GwGR8xgEcgZhotLfCGvXH65efJ9beslnsfvwQD9QUS/sD71Oy/dIH1BjRvl05
         MgB1txZ0uJK8mk2om42x3xjSm5VkXBG4SpUBGl6ewbnFk2d7X2E0MDaBBx+c6DTlJTOt
         HJstxmRabNK92/+NjfsgoS0QDMw6qgy/M+/PvyZLkA+BKo19LoQKgFwEEq7QlNMf0HEg
         Az1/HIoKtcX5tGzPiZ4WpHQGf7Mu+hJ9PKhAu+++2vuhyeZ7IA1bR05EUIro/fooehOp
         xg1ZDSfETRVbyWWI9eqCVNegA9kblL8t+sU7jvBgWhEWLMpuKrbxMFysqceSrN48zP9L
         poDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732661; x=1787337461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=IY+OvVhiuCb7nsN0e8KGulCMjo+9jxbGOYhvBkTu5+VnnnQQtmE+HD2e5US+rQVreQ
         TD4eStcjyEc40L7xOnnSBo5Ii3v9vDLJNUb0e5dxhDdr0+z7OLkP7x+T20k45aSSYIv2
         808BsVOiiR+kBUAnQNbIUrPaDTH/cu2S1Pk4rc7c2dCXtS6MqtXqo7VPdqfe+eP6KH0P
         giX/jDjy6EnekjLeiKj+M6UWunc4Yusg/jQ9SL5OeX8O7m6xaNlTska5scpq2aNJ+XhC
         gid580+U8hz+NHgkUywz5JsuRGzMMB/2ehocK5rLHzjsf8fTbw1/Pg87e15nnTPpQOkG
         pQ6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqrNNReOf82tadsU5Hqr56R1J5CeIRrUJWYFBzZnWbFAONzjTB49KW5IqldXyzbWFa+csg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4byTbDoDi/q1GttOTuN/JUB9y7Op/+8a8RVlyIABn0SsKNXb
	TolUUj5zfAa6NpPTRdoqn7eWVPhk0giV6dyDI725CboNiVIplQPcOHQXd3ZFFGAiV5J1DeGgWPp
	/Z1YcKUWF8z7IeYOhhmSYYLgRP3AyzZzMo36bUwypy9YoI5gzEvmUiOhr0oildMzMbzSq2S3I31
	s0E5Kr1D8sV+sdRsuSqREy+7/vhXTz
X-Gm-Gg: AR+sD13UrpIAodvfcOC5uVqTWWPY1ZryMVPT/FZhnJD+EYdQCxUJoxfHVYlzfLdvm/z
	oMPBI/qU2Y8olQnckmAzpHys2WZDE6+iRN5R8GAhZHeSuo/jcEJEQ8hyJALn/btQY66x8pqe1xx
	cryiYuNrFO0pkYU7IKO0e/u7GnnmhPu7MU7LAoVnenDSxQNM3SIyDGJgQ6ak2GX8DgxZeLnVi5H
	ENDoi7srIJ1AQNNVLYZiKL60NIO1V006oNcA5Hdx/z3pw==
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id a640c23a62f3a-c212a23ba41mr343802666b.30.1786732661700;
        Fri, 14 Aug 2026 11:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id
 a640c23a62f3a-c212a23ba41mr343797466b.30.1786732661284; Fri, 14 Aug 2026
 11:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786626275.git.rrobaina@redhat.com> <an7Udt-luZfJO71U@willie-the-truck>
In-Reply-To: <an7Udt-luZfJO71U@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 14 Aug 2026 15:37:30 -0300
X-Gm-Features: AUfX_mwn2tCHNr249W_00_JVZBPk2OAqZsqdPsMuBo2JtJrJsV0GhfYgrjHGFrM
Message-ID: <CAABTaaCcyTLV5TdmzZfpP6LMV+5GeCKqotPoJrb0u9n0h-TaHQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the SYSCALL record
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:40=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
> >
> > The audit testsuite runs successfully:
> >
> >  # make test
> >  make -C tests test
> >  chmod +x */test
> >  Running as   user    root
> >         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023
> >         on   system  Fedora
> >
> >  amcast_joinpart/test ................. ok
> >  backlog_wait_time_actual_reset/test .. ok
> >  bpf/test ............................. ok
> >  coredump/test ........................ ok
> >  exec_execve/test ..................... ok
> >  exec_name/test ....................... ok
> >  fanotify/test ........................ ok
> >  field_compare/test ................... ok
> >  file_create/test ..................... ok
> >  file_delete/test ..................... ok
> >  file_permission/test ................. ok
> >  file_rename/test ..................... ok
> >  filter_device/test ................... ok
> >  filter_exclude/test .................. ok
> >  filter_exit/test ..................... ok
> >  filter_inode/test .................... ok
> >  filter_saddr_fam/test ................ ok
> >  filter_sessionid/test ................ ok
> >  io_uring/test ........................ ok
> >  login_tty/test ....................... ok
> >  lost_reset/test ...................... ok
> >  netfilter_pkt/test ................... ok
> >  signal/test .......................... ok
> >  syscalls_file/test ................... ok
> >  syscall_module/test .................. ok
> >  syscall_socketcall/test .............. ok
> >  time_change/test ..................... ok
> >  user_msg/test ........................ ok
> >  All tests successful.
> >  Result: PASS
> >
> > Ricardo Robaina (13):
> >   audit: log all six syscall arguments in the SYSCALL record
> >   alpha: pass all six syscall args to audit_syscall_entry()
> >   arm: pass all six syscall args to audit_syscall_entry()
> >   arm64: pass all six syscall args to audit_syscall_entry()
> >   csky: pass all six syscall args to audit_syscall_entry()
> >   microblaze: pass all six syscall args to audit_syscall_entry()
> >   mips: pass all six syscall args to audit_syscall_entry()
> >   openrisc: pass all six syscall args to audit_syscall_entry()
> >   parisc: pass all six syscall args to audit_syscall_entry()
> >   sh: pass all six syscall args to audit_syscall_entry()
> >   sparc64: pass all six syscall args to audit_syscall_entry()
> >   um: pass all six syscall args to audit_syscall_entry()
> >   xtensa: pass all six syscall args to audit_syscall_entry()
>
> Could audit make use of syscall_get_arguments() instead?
>
> Will
>

Hi Will,

Thanks for reviewing this patch. Yes, I think so. I'll fix that in the v2.

Thanks,
-Ricardo

