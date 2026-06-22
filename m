Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AD37267E
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126812; cv=pass; b=s847pmrXe0rX98iLxuqUlQYOM5UDcRxDgmkEDVRxNpZTQ1C5TPy6PoxCQjB63otZzOAA6VLxI2N8XYeZyPs9br99FOybKHKajZ/uxYj9HcgkcvWAGkrrN9bTCvRJW3+HRprDN0NmIIpEjn7yb0deIONsdkt6yW/GwoY75+6W2A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126812; c=relaxed/simple;
	bh=ayL7NDVLPdIB6IO71jX5DL6LLM8P5NIhHXQx77l7nEo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VytZ8N+Mf4xggBWhYuK4whNpydr7YXa0rmCkKXfMMgRlf+Q0LIz2j2twa2gqE521i+j3YtnrTIiQIMV9MYdshn1ZyfIMlyMLzDApiysGN6qqcjCPx/EzG4gyl/6LrFvODcPosY8kpWCzWLD9kAG0vTLvhHCvBxjbkBdIR4Nlzh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMsEySCi; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMsEySCi"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66077e888b2so3992070d50.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 04:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782126810; cv=none;
        d=google.com; s=arc-20240605;
        b=FFwNPK1vOxTU+mOASU6nIfBLsa0AiSP4gqK78bGCFy76i5aPqULZA2CIc1JH9DOvNM
         feUv17BoZTTP4PQFBo3RbsjP5rM9tzh307R8OxXx8XFF7iTERme//W8PNbN1c2VK9ql9
         WA8faanqWyrUAWSuJZrLifRMVUpjH8G9qu4sINlH+uEykzfkqf12kWahp6g2dzhwCrfA
         1GZKlTs8V2yNwJyo4NATPQk3TlXA6U5MmG3dXsCEDjmCq6JP2EgPK7IYr/XTBcH0tY+r
         u/zGrQ1XKOqW912EgFmTzE0qXEUeOVetXOWTbWu70I/fOSYsYeVZ0oYL/Af0fXqjq7nS
         YswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ayL7NDVLPdIB6IO71jX5DL6LLM8P5NIhHXQx77l7nEo=;
        fh=xcfiJbAMYym/uG4UVf7hkYEk7wvDwEamUHlPuuOKhS8=;
        b=AdQuiODLz3t2gswvihjgfXi4vZydHaZBe38dD6NZcMTg8vkL1PBKeQhuBmHlmqU/Lo
         njMfY5nXLSrHUX9m7StbRbiNiryuQ2tJlL0Kqu7A5CUWF2ABND7CVenn9uB0vfAk4O2o
         7LKWjCMkJDkOk9hd8B5zaHGSRfokG2VH0BQHarUN6RlvHLkJ06j/zQwIysUwfvVdijP4
         a0XEi/XBhHBhI0nIT3ERXsLegk+snOb95CYgyxEo9jGimebYad5YbznSSAazFGgk/x/n
         shg6L5uzHLbCR1bP4TMxiPZiUSdnUBKHRUFknaW2pQG2R8TPCuolnpLJ7RFtikaq+bVg
         F0og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782126810; x=1782731610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ayL7NDVLPdIB6IO71jX5DL6LLM8P5NIhHXQx77l7nEo=;
        b=GMsEySCiwIf9sIUrzbIqLh0FbnoIoogOcTbiJH08UIBRCf3+uKJd7w93b01+3KcCNl
         qEVfhJyxl+MFA9OlNpI560ly+i/R1V149PbnrSTfrJ/aEf0UyLtCpBvVEHZsM4gzVqMl
         E2jwI6Vth8tuOrUW7ir2/m6WTRvM4UtXsVoqZY6uzqgzyRanhuX0tqFTGSF2Y12JZMAc
         +SoBQtG50yHeueIMfOERzj4InNpTZxKOaQkp5Ibpk3aIEy8/j0dvHxAdmz7ij+leHhpF
         UkXd6fu6DpzKH1dyN8veQAN+brttnbTj+SjAEOHBLoIeJMk8ahQlm+9XUUmKOBKzQv/M
         VPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126810; x=1782731610;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayL7NDVLPdIB6IO71jX5DL6LLM8P5NIhHXQx77l7nEo=;
        b=MxsGmjoZDCe9kW61bzs7+aPJ4cAhiPwDizK8UV1kKE9K6xWgdjr+QHzjfjaAwMKrY9
         EhNiUSZsKtsSNFMwhjayzlDcbIXavTsjuyVeazWuO8eRCWxprqpYVGNMFPWPclcNJJJg
         vbBNXuuBM55GNz24FyEvXKW+a+x2Xpa0Ipm/FQ2gL0MtbgnqeMvpvnF8zd1OMh4D6pg6
         6cCw+gZzOqrYhHdQie+lCDA8X7S/qh+qWdoNkkdGRmbASeqSzGFL0/pzcpbz7w3hTNXy
         Haslc3BWKtGXwcxiGrUxkgSmU0BLhIiQPRDkvj75oVxvqfe9S+6xhXE1rRFNZiaNw1JM
         mq8g==
X-Gm-Message-State: AOJu0Yyr66B8OqR3CyhOj59fT3iocilbkCbbEBH2e+Bk7cT524ArI1kO
	X9D24ad6OxdUzgsE7qLhpXvCswsu+ND0lgVH8moOT9q6gGkcXYTndrp5UoupFmpynTyEisRBhak
	xe02K0am/HhpXqzNu8mw+5DbxzywtLrADwRiD
X-Gm-Gg: AfdE7cmP3HeUvqBrJKu/BgWgYytm2Sy9y/QrEWD7LJ73n4fxdwgO5xdSH0DTg+d261G
	zqJ3OM49xWd0ZizNi84uvrFiR7XGVhU6PZM3q36UnX6VI9w/VVxmAw+b5YMyYpFvsF2nFrdL/yK
	TR1TxcPKW9ZKXmZTx38ZNv4DzlYs7E0ATR0GjBu27kRR1f/bCenTogNxsXEne9juOyhDeWrUm4d
	c2wmUbK7ZQ8CEGE1mj7XRFb0J+gx49HsRVDsM6Lk+N8HDVCUfGKZSAMYA0apCk1Z1cvnQQ=
X-Received: by 2002:a05:690e:c4d:b0:660:eff6:fdfe with SMTP id
 956f58d0204a3-66302ef7ef8mr10859398d50.2.1782126810078; Mon, 22 Jun 2026
 04:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahnur A <s.mahnur.a@gmail.com>
Date: Mon, 22 Jun 2026 13:13:19 +0200
X-Gm-Features: AVVi8CfUMND5nY0ngfXBdmlF7GbOHX3f9QXr79sEl9JGFhB8zZLJVdBKdwJVBpc
Message-ID: <CAJ-umGR4Ut4KG6kLA=gG8GdL_eWdf72AHdRaAo25VgCrzYgnvA@mail.gmail.com>
Subject: [BUG] bpf: verifier bug, no program to jit at insn (subprog < 0)
To: ast@kernel.org, daniel@iogearbox.net
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This has been tested and reproduced on the latest kernel 7.1

I have a bpf program that should pass the verifier, but fails with:
verifier bug: No program to jit at insn 16 (subprog < 0).
The bug occurs when bpf_loop callback function
is eliminated as dead code due to nr_loops=0, but a reference
to it is still alive.

It only happens under certain conditions:
1. bpf_loop is called at least twice.
2. The first bpf_loop does not have nr_loops=0.
3. The second bpf_loop calls a function with nr_loops=0.
4. The second bpf_loop calls a function that has not been called before.

Please find the bpf program, verifier log and kernel config here:
https://gist.github.com/MahnurA/939198e276db4d833a45193d71533711

Happy to help with any other details required.

Best regards,
Mahnur
