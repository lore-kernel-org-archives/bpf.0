Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1B3033D2
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483283; cv=none; b=b8NZC7H1TdcBAPaWHWcDiDmCXptslrtM7SpEm4av7ht5U5Sx7XcNvYBoeQ+UxaLpR/fmJg/mct+lXUEMdjHezFEp1HT9ZMsmEU7J7jjVrMZQ/LTx1tDyS5WjSyTwwR6zFo1gmzHDKECLfEpg1YGVQv9EJVrh5qS1Js8V/ZPeYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483283; c=relaxed/simple;
	bh=DIb7rNNr7SOOh1wA+ne9D8XUXUURkYnqwGTJQb7003g=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=P6Jz0u4gHPNB+KgiMTAhK+o83OAAyHki2v62256jBNoz7SgwYwG9xzbaWUP8/XF1b2ORHot8c4dRu5fafG/dyp9H4QvuJKeVzvUqz400W403eTINbGr5sm3f1gUFxVQKI5DfuNqLJYzxC+x9ClObmpJkGV84E7GCQpRRAIUm0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnpATh6f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnpATh6f"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a2d107bfso230892a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 22:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771483281; x=1772088081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gmx/gqQrBgfYHm8brTnnCECN/ydYL+orFNc2dUXFmes=;
        b=DnpATh6f5KMewdgNbpjxFWyMvpJmdSQb0v80PNp/ZPhEsVMG3vdbDI1aH34BuVcp2i
         YiMYhYW9VkeGW5CQLFIvRC/xSkoEn7DR6Quv075e9eC4UilnoujEYnYtF7Vzzn44kLTX
         y1TVilr7BeKnPX6R52vHaP9DKRT+JUJMyoy/pmgedMtvw1HMQQTS68jFCIXZPX+wFNLE
         PXFJVikuUHc8X/ocgBfMyLxXh7JIUp2z6dIPY0v/7L8RPK1FiU+vbAwmLwePzuJE8YJi
         Td4bplafwRCspjvBjwv5tS11P1kuGsTwUsKoHNhBomBTitYb/5gDY6hDtbaMfkd0HRUW
         vivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771483281; x=1772088081;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmx/gqQrBgfYHm8brTnnCECN/ydYL+orFNc2dUXFmes=;
        b=Otk7JWAZmj0zF0ecNt4gdd+8CQR/96GUU28FTKavSW8UFhggLws8LrG9hsTtyh16aT
         t2TjlzKM6J5taKSSMulJWOdQV/KOOZwy2EaTRNrSaL93z0HshoCzdbNGPmxbsvKfaQOB
         xoj7kfr2qzuQlA9Ps8qj0oY+FmVJRd7pvylc8L/ClMW4hSE8OU62DLRBYcGnQ4BO2WXp
         8rRdG8RcHaJEOcnutiWgRA5h8Pni4cPjMhLHB4zjaqAgzNvXXc6F+pY0j8TuIcY2my31
         oCogOIgac85tYC4lnezz0r6wfVBzNIj6oFgmsBVgEqFxOx9k5dS95tADliMLjwHmCzh8
         x0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWutumgpRsmUDdQAGVitl7PYfvczSMmRaqr5ITLNI4Jf96BEm+gE1TTl0mcHZFyH3PoM+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwDKtNPQkBEJ2srDUoZtqPqUQkXzAV1YnQhKrHWH7LnTIFWg0
	POBnZ/fAXKoi8GJauUSNHuudjmqIzfnyLxLxN8Xp2OjS4nEAtqj0nVtIq3aIlfzF
X-Gm-Gg: AZuq6aIBToqGKn03nCQwfYHv4BfJ/BOMOaMkHUSd4IGD+e4PNPAJIXyIpj300PRaJIt
	7y+iZrBXIQKc6PheTkxDOG5fPK8QujrkboIAf/EVmgvlSQ4vz//MXxB9tfcvVjAJvgzTE0uHlny
	W1X1c1ET0VB78Jd0DJmLgArOQDpLyqrA/uWBr9W2ffiDYac9Pb3sW5wAMxjRmC/HwVndgScY4B7
	HKR6vlYMpKCRXV3a/b/NP2RZtiIzvh/U97H6RUf8/FB4owX0YGmh3u5pi3zFpqYI+vBG2nIRXS5
	vsZV6fLmXNBVAds0x3HxNzbXjYIiJGb2FRIkdHpuqZX8xbUFYXcypyMyoGA8nS6aABY10yZadVM
	WOL3k9tPnGT2HFLj0qg7TmAO1flzEk+83yN9PSKoZGxc5cUsxaF+LupenMHPcAFegtlyuxkHKV+
	6nPBwlTNKA/3Cx0w23tC0BpAQCOxItWOJpD8Aa2R+fT6S/fiAOa0U=
X-Received: by 2002:a17:90b:50c6:b0:354:9bc2:8821 with SMTP id 98e67ed59e1d1-35844fc80e0mr13123209a91.30.1771483280964;
        Wed, 18 Feb 2026 22:41:20 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567ebc4331sm23894968a91.16.2026.02.18.22.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 22:41:20 -0800 (PST)
Message-ID: <f5efedb1e8877254d0726890ae9539c5ba880794.camel@gmail.com>
Subject: [LSF/MM/BPF TOPIC] Scalar Evolution for BPF Verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Date: Wed, 18 Feb 2026 22:41:18 -0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Everyone,

I would like to suggest "Scalar Evolution for the BPF Verifier" as a
topic for discussion at the upcoming LSF/MM/BPF conference.

There are several ways to encode a loop in a BPF program:
1. Directly, using a loop counter together with for(){}, while(){} or
   goto statements.
2. Using iterators in conjunction with for(){}, while(){} or goto
   statements.
3. Using the bpf_loop() helper and a callback function.

While (1) is the most natural way to express loops for many use cases,
it also has significant verification drawbacks: each loop iteration is
verified separately and in full. When combined with nested loops or a
high degree of branching within the loop body, this can quickly lead
to hitting the 1M instruction verification limit.

Scalar Evolution is a static analysis technique used by both LLVM and
GCC to estimate the number of iterations a loop in a program=E2=80=99s
control-flow graph will execute at runtime. The core idea of the
technique is a one-pass traversal of the program=E2=80=99s control-flow gra=
ph,
assigning recurrence relations to variables within loop bodies. For
example, consider the program below:

    while (i !=3D 10) {
      f(i);
      i++;
      g(i);
    }

Scalar Evolution analysis would first track the evolution of the
variable 'i' within the loop body:

    while (i !=3D 10) { // i =3D i0 at loop entry <---. Arrive back to
      f(i);           // i =3D i0                   | the loop entry=20
      i +=3D 2;         // i =3D i0 + 2               | with i =3D i0 + 2.
      g(i);           // i =3D i0 + 2               |
    }                 // '------------------------'

It would then conclude that the recurrence relation for 'i' at the
loop header is 'i0 + 2*k', where 'k' is the loop iteration number.
When combined with loop nesting information and information about
conditions guarding loop back-edges, this recurrence relation can be
used to compute the number of iterations the loop will execute:
'k =3D (10 - i0) / 2'.

I am currently working on adapting this technique for the BPF verifier
and hope to have a working RFC ready sometime next month.
At the conference, I would like to present the main ideas behind this
adaptation and discuss both the coding patterns understood by this
analysis and those for which it fails to provide improvements.

References:
- R. van Engelen, "Symbolic Evaluation of Chains of Recurrences for Loop Op=
timization"
  https://www.researchgate.net/publication/2801813_Symbolic_Evaluation_of_C=
hains_of_Recurrences_for_Loop_Optimization
- R. van Engelen, "Efficient Symbolic Analysis for Optimizing Compilers"=
=20
  https://www.researchgate.net/publication/2385991_Efficient_Symbolic_Analy=
sis_for_Optimizing_Compilers
- R. van Engelen, "The CR\# Algebra and its Application in Loop Analysis an=
d Optimization"
  https://www.researchgate.net/publication/382316876_The_CR_Algebra_and_its=
_Application_in_Loop_Analysis_and_Optimization
- LLVM SCEV implementation source code
  https://github.com/llvm/llvm-project/blob/main/llvm/lib/Analysis/ScalarEv=
olution.cpp
- John Fastabend, "Using SCEV to establish pre and post-conditions over BPF=
 code"
  https://lpc.events/event/4/contributions/450/
- My work-in-progress implementation:
  https://github.com/eddyz87/bpf/tree/scev
 =20
Best regards,
Eduard Zingerman
