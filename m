Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5E21A434
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219146; cv=pass; b=SVPNc5Ztsi9QtPi47kh3bXReuCFOYiyxyYJWdpXZb5Qz7JFGXY/FvtWHocXmZxMIX4xPi2w0zbV2fN4dDN5N/id/MGOgkUAgX0Hc5RxIMF4ElbYAqKMnPTr4fB4aIssu9pgW75zzl2rjt+ShhJNXjUt7b6I/vZrL4Z1PKgbIZyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219146; c=relaxed/simple;
	bh=cTydM6llwe17dEOjiDWqAOfd5hLsCH5gFvItqj94xXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d01jfDLLvA4iNZiJ5mBBzKuSQhSyvxdQTle2oIr+/SuNgdxOs9zQPmIQzIBEE+XweWQK9iYLvDVyggqh0jX8iGIfAewB9rKE5Y8A0XEKamKEkO+7cSK/2jPzXrJnuitu9cAZUcIV/LQzc34ZWnVcxcV1rOfIoGB6xj7uLBNe7FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6EKho63; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6EKho63"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-127380532eeso7374767c88.1
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 21:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771219143; cv=none;
        d=google.com; s=arc-20240605;
        b=IgwRlpJQotKVFrlqce7TRrvEgRbN1ORvFxQkXkyKSCU6jkHrs8bgPWgio+CBRX5gSk
         tzVzaT5hA0XS8/J6PlGLZPOSwPUAI6eDJKDJbAGLR3ytfbUvwjKrM4oYQN591svddmdR
         rEEmuKBRH78wVj0+l8eKM4WUi21+CfXFMnLqkgeIGlwVh5HrTprqcmI7Jmgtv/n+XB7m
         mcryI/BdIcpTccr1x2bVMjtPe9qg0HtUCl7Blqv6r2aAb/bokJOqby3cWEq54HRpV7q6
         PPZRhyI4njiwJorCABYOcnfOMaCcLgHgHeEoNbao+dofA4FNG9jh62O3Y9rWBS4AsvEs
         CGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        fh=469kP6mktMUNyn7chkFIAy5l3FQhFGQ/VS524vOVjYU=;
        b=SJcaXbLNhD79PQufoOmDPzf1GYVa8sD5ocr8kg+//ZF5aNuyaeObGSVzwW5pcnibSR
         rq8iKhVuer39NfACjJZ8LOXTDM8WgsUr08FbhuaUKZIfUUHSUfe5FRDlYCg9sldwK27a
         odVgsJOB+CvkKToPMSfq/hfSLpBQF4hyG4xIaQl9F99bBpB0W+SnRiRgxqbszVJoLcWi
         Ma1ZtBRX6VRESureL7KojHco5LO4bTsspIs/xSkTTKSnbdS6Sf914LPR+ZaqrE2xkmOF
         XuPnQTJvm7xzgjgOXFYnxX7eGGj6iKGtxLTR3UQUcXz/X4X3pCKk25ywmzfAGNt+anf4
         pzOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771219143; x=1771823943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        b=h6EKho63I5TnD1ikWcNLyhgyfC+oQDTBlzk63i2HXzwM8AOiHsp75mpkoKJnOZ8XPD
         zEZTYfHps8kdI7bI0VV1+5nJvOMaRdcdXdR/S0V56mLrsASjKE45+MK5VwvDPROVMtlE
         8zfk1IF64aA14SfqeU8IHc8Jup+McfyWXdi7u41iSzOHiNMplJsCgOleCGzieHEw9ox4
         Uja1cJ38TF+wn8jAYppNqpr7eJGSOKLsk0ETOS1dyHmWFJJpdGNtF1YKuYPssj1YETkB
         UiotzUuV1Lx6wz19xktzqFjRQqQbzqVXZo8t6PwRMbD+V36rrXtwR6JC3J2hoDyHsiPN
         PJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771219143; x=1771823943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byzn3mYrXH2f08drE1WkmiXr5JyMmD4IsRirzVhSrPA=;
        b=wM+TMmmjPf8WM0rScuP1Rfj16tIgAYWW96w60ghSUHV3O7JMSFIAZbiySO1E+n5UHB
         v/edQxw3xXwJlU6pXEMfr/Z8yI5fksqJjxZE7DfaMLLlt97ojOQkdKB6/SqXKxnE3sBQ
         jGrPPi8B/Ejtz8eFrWP8//BOy/BJGO/JHKfaPC7t3zqqyGXhhmJNpLGjdjsyE4/uS6Vf
         yeB2O9KiB52wBVc4Fs6fvDu2sWHJiLVM57LzrXBBJ3CzW9c7IvyG37qyGpp7MmeCOizm
         +fvgGl/JkOva4e9Mo/3l6eDcdGEon1FUnehUGUW/SU6OYoFnwI0h/4zkngjNleybEp/y
         NzPw==
X-Forwarded-Encrypted: i=1; AJvYcCXNegsCIim2rgMcLNgdmVMWWJvNJOnMv6+rh6HH7pBXp2zCkOpiSAFvFqto92Z2y+q0RI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBsO0wb3x+o/umtRD9X7MNMe0fh3HZTJ1ROY1Oe4u7TzBeVBy
	ckYLlaJVPhp/9RstdSYK8iXX54mRXrcCf/mL8jZi+zJzIH6i4tpzw7zEQnIoN/wWTmovG6yo1fN
	wnYhd1bD12JmvfMaAK6pLAObXeuzhLAv9fpoUuIys
X-Gm-Gg: AZuq6aI8CQg5F51C/TkcbszOd93jGK3c6qGG9uhLb1MJtn2/B7MrDLc4wGCPsJjIzAi
	refrZhZqeoI3f8ahdySVxl84c2zXdvr3BIVYuymq9Ti9GwIZJfaQIp7gC+uFRUm2krh3OEvuNyX
	jFkLeUHqQNGeqbKXYkOvexWMpQHXhjqGya83vDpNaAmz1v5YmO0sEualReQ7QFCNswfpdcPW/ug
	nAgSZ5dH6k5U+LRu0OWSc0cRoJcc4Sb7j29aGSCZsVDtNw+R5H+HwyTqj40Jnfb1WE8eDC+6vlQ
	qYrvqNxZD12ZnqdWZyR041PrEGj0ypwLsO0YIgNCBqDj1Qi/HbPyJrIFuIeOsIuT7j11Mg==
X-Received: by 2002:a05:7022:41aa:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-1273ae20572mr5446447c88.18.1771219142650; Sun, 15 Feb 2026
 21:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-7-kuniyu@google.com> <202602161010.ohfwdwoo-lkp@intel.com>
In-Reply-To: <202602161010.ohfwdwoo-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 21:18:51 -0800
X-Gm-Features: AaiRm53TuLLrj5i07WCfZaVSzTTG-oZE_UcBw7XWP_S2gWKmb775mn2vrkqu9BY
Message-ID: <CAAVpQUCBY=rcJdBKNb5nMWnFvak7dVzsF4_SpKfJKSWkqXaPmQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: kernel test robot <lkp@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	oe-kbuild-all@lists.linux.dev, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 6:51=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on next-20260213]
> [cannot apply to horms-ipvs/master v6.19]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
sockmap-Annotate-sk-sk_data_ready-for-UDP/20260216-044819
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20260215204353.3645744-7-kuniyu%=
40google.com
> patch subject: [PATCH v1 bpf/net 6/6] sockmap: Fix broken memory accounti=
ng for UDP.
> config: x86_64-buildonly-randconfig-002-20260216 (https://download.01.org=
/0day-ci/archive/20260216/202602161010.ohfwdwoo-lkp@intel.com/config)

Okay, CONFIG_INET is not set.  Will fix it.


> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260216/202602161010.ohfwdwoo-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602161010.ohfwdwoo-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: vmlinux.o: in function `sk_psock_skb_ingress':
> >> skmsg.c:(.text+0x8fc777): undefined reference to `udp_sock_rfree'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
