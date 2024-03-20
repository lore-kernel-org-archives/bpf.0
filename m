Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB717BA1
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913616; cv=none; b=pF/eWy/BKxwbG35A7UdsySL3TVylj2i0++ceAxt/cmxPb/fLTJnV11dLjN48I5DCnQ+wzSS5uhLC4mVQg/FNzJz5PDqYeJGDO5u+62LPnMVOe3BUAXX2VP75MPkTcupGx0tyX+tWbxjbUX7zJzLm/Il6b1KiGcFdpROUBob1uUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913616; c=relaxed/simple;
	bh=N846R8Y5WTXdloCuk7XCQL/AlKAnz5ydmjUuACDRf1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSQ5gkPkL+GIqedMfguBJnuxxhoIUuDfYBStrqvoGseG1Ya3GTZFbBfiYQz5QIEhfJzpwPATbXuAmvhBtIbZZvl1p+CyHzYIkkFnImL8K8zO+S+AVAtooKvgU00gXTNnf09m7MJTpQ3rAT7UQNkmu/b4LwEgMK8i92/Rq+UshNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5bjVWwV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5bjVWwV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e162b1b71so5396098f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 22:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710913613; x=1711518413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N846R8Y5WTXdloCuk7XCQL/AlKAnz5ydmjUuACDRf1s=;
        b=D5bjVWwVeem81l37n0E4emsG5JFMpYbE/Q/e/VvmG1TRRL78e5Cyvn7JLN5yJ/pYMT
         8CwNShiA5XtHm1WCYIEw+8BXld1Fo+W2znGqcG11ckekJLT7YY1b88Qjfv5H0qiBLvpg
         MIOk5Qz+DR28lA1Agx5rMVpwfTlMwtgwbJYg6NZWkLOniWHqaFMmQfHCprRPaRBuZPlF
         5jxCSQuIjI2g3K6Vi4+Hb0NPkYE1SUO07BFnq7ttpmXFbTAPoKt8FFrAJny74JmKg+Lc
         e8RakTMcdqPuKNE7Ci6we54Ge32SyS6eq7nqsS7h0pwnwucWGuanMFgjkdrM/R34CjaN
         PI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710913613; x=1711518413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N846R8Y5WTXdloCuk7XCQL/AlKAnz5ydmjUuACDRf1s=;
        b=XoF8Juk4b5JE/9io0bhfzou6YmKEFQSiQYSJDHKxwCyICgtKn5vGh5COzlLzyLnEN7
         IwF86pxgktqYV1e3yIGs0rJLAFdxrjBTG+PKYSd0OYkjIdl4kEZZ9nezZO9LdjFGEmu+
         imEoPJLO8qLXZwEjjAyjiK20VlO1l59SuEeabdakKtg4M86fwc8rYLKL5gGqN3wpf36E
         K7/4AE67FgiVx5Rbd/Kg0+1lJnETZ97PgDDzZP3sNe+6b7wrhsvFYEF0cdIl7nxhHqvn
         y6Ojst19vFm2q/R/X/WHQQWRkNBol2P7/LKNEY/J3Ot57gS9IUxClsf4sFqEDTFEelIc
         a/Nw==
X-Gm-Message-State: AOJu0YyU01k0xX2+CxBd6tzWTC+6JU6hIxCGr9vbGGv4yKxKJWlwI6Hs
	/Tqsck+zSQkbkGDEavnCUOwmym7IrObJNKjIrkTuQEQiLmoR7yNq6yQO402ugSSE0791dVVrMRW
	+FW/n4AJCz1/FdpkY6YntA07/9MO59kpBxaerOQ==
X-Google-Smtp-Source: AGHT+IFBh2/f9YPkVqsfbkYELRXjcA+8CmVfosrhS8IDti6/8NrtSiZ2C9DVW8dsaEQnW3x5V3kzY2HyV+WuJAB8LXo=
X-Received: by 2002:a5d:408b:0:b0:33e:745a:88f5 with SMTP id
 o11-20020a5d408b000000b0033e745a88f5mr2915814wrp.57.1710913612465; Tue, 19
 Mar 2024 22:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
In-Reply-To: <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 22:46:41 -0700
Message-ID: <CAADnVQKN5Hk7CHgDBg3JtPoeYXoTNFoXCWp_u-2YP9dN7juavg@mail.gmail.com>
Subject: Re: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
To: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paul Chaignon <paul@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>, 
	Santosh Nagarakatte <sn349@cs.rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:16=E2=80=AFPM Harishankar Vishwanathan
<harishankar.vishwanathan@rutgers.edu> wrote:
>
>
> To run Agni on the latest kernels requires a preprocessing step because
> regs_refine_cond_op has a goto-label that introduces a backwards edge in =
the
> control-flow graph of the verifier, something that Agni does not support =
yet. We
> provide a patch that essentially removes this backwards edge and makes th=
e
> verifier code a DAG, while keeping it functionally equivalent. The patch =
and the
> instructions to recreate our results are available at [2].

Thank you for doing the analysis.

Maybe send a patch to refactor regs_refine_cond_op() to avoid that goto?
case BPF_JGE:...
can be moved before the main switch as another switch
that flips opcode.
