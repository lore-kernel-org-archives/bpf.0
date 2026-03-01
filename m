Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8832212FAD
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772331307; cv=none; b=a3T4ZUEt+3kNa4nUWtJzIm+zt7wAkW+mBoEMGlXGSGoEkFR4c1cNIxz5Ql+q3O+aNsSHC511NzVDiluP7vBxkXEme022cTUa3Qa1FjmHPl4Wo1mUa7U2PgME9oMSk7uLmhnrW3JJQCQqxrUVBSEbBLFTpJN5SFgyCFA2mad4Hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772331307; c=relaxed/simple;
	bh=DWIxK0/LtIGmi9vqyI6Q6hKZrwjUv+7OgQOMBi4wqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0SmTJxGkf/MCB1jwBCkCMcccSIvz5WPm24QSvDYsWslxUwQXBngfTH8ZT8XS6PRFHEtB7zWIXB2RIaOVP0muvJshYed72Oc5NruBdBVknDUKSpZc6rvu4p2Qvi7ytGuNoMqzqqH3fPSagsMhGqz6ER3G9ADSZ3iPMlORaPQ8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpEAwAKd; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpEAwAKd"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso300177eec.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772331306; x=1772936106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6EnI13eVrOOB49RugkPQuOhO7vpKFI831GwIhZKjD8=;
        b=TpEAwAKdfGnQz8n0dKUG5phAJOKr+iCz0BCVg3RZTpa7haYIBdHaSsP34Ra+zd/Ilz
         TwjOvrvCfK+tTqxsSbLWI8m1wLLgrzP9ityxaJll2rssl/HKnEMERUNL8y6NKKDXiIOn
         M2cUFsD/uQBauf5V3faVdg8pqTOPI+LJbZVQVlNPk96ZR4tfnaMDK5UerGbnx+9eJ3Xc
         2G/cdcD32G/c6buVBZv4SNDmhE0/PGsO/q3qYNkop3Hj4G5mEZdFMgDmrD3DUOjKVgR6
         852pOcv8xRl9OmnOfQDD1L7cKEQu+46akOwNbAppmUBfs+96EH7mvn9TQ3aUFI8cFePE
         f58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772331306; x=1772936106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6EnI13eVrOOB49RugkPQuOhO7vpKFI831GwIhZKjD8=;
        b=Noln78jzqRWdYArObNIo5O36WNkh1Rvb1BSEMlJxlkxPD2yuK0npk63GPUkDaQt22K
         vWVSlzKxNJy02FxPmM6Gs5KKsCKDiWofTW9hLbG7YRpZNR9d0asmnd9SVP03kjxr/ISb
         ijzVHlXPwVHfGnNhgWL/Ot/bS0gLWXmFG1McidV5CS2UjH8zb4c6B1KnpDuPLl1QfFP9
         CEFr4yWP25MqrIPfMsEflVRBrmDI8Wvxh3fkBrruijCydeHTnIzEXoBSoaAS24GHbuS8
         +rlu6tWOTy6X6uoLADbluyovclcntSa+DuFEI8m5fzq1U3HOl94BjZtVRa3aChq1dKiZ
         +qTw==
X-Forwarded-Encrypted: i=1; AJvYcCWymXG6QXiBH8FaQnW+Y/om09eUCdjUkEl6jvZ5G3rKhGQH3agi9+LBDcTd5twYy/L66qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTO0euzT3Dynay4570zGFW+tNjhr1ImOA305ynozvJZ3FCO2X
	aps7OCVNXfRQatkUjhxriB2JrYn9hpMnfClNPXx0nFr6rOi2hi6MJ6nny1kIUQ==
X-Gm-Gg: ATEYQzyOP0Ppi6LTEIFnxw5bqyYvZ8dLT+fslH7ij9DRmfz9W6WlBzOIJm0nf4T3p3M
	60tQVuMXIzKlZ8yJEr+wCOnb4sn9p8C9/+GH2hq9LedK+Nav/XoP3OWQTS8ffOvHenmuqQAFIoi
	KXc87XsKVtMj4PF2v8B8K/g/m/K88fZ09jS5hD1ZXts+Iz1hwt5g8ZXFfcfg79+qWMV2Gs/2djh
	Rj8a7ndC6J4n5TsZDO17z1HWiJBjJsl+zquZX19A0Ph1N87eAp/AxDscKxApCjCH3+J2iwIdnEz
	JS07qujp6PAM1BT3crtTA8Rdl7ol6w3ZGcRK+jPWF2hDzTe/SBlKR7u2GGr8Uw5GFZJA6cqNHkx
	lIMfNiuewjsvVrdDhapGvje0r8Z2epE/l91z66C8hzFecgqO0WaNGux1tCsWPDMDOSHc5tNTC6S
	Rc/WHyJQuCASTrQvz6IYma30qo2jOlpw==
X-Received: by 2002:a05:7301:2b06:b0:2ba:82ca:b19a with SMTP id 5a478bee46e88-2bde1d6c384mr2637938eec.28.1772331305577;
        Sat, 28 Feb 2026 18:15:05 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:1e56:f0c4:e708:15be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm7558733eec.9.2026.02.28.18.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:15:04 -0800 (PST)
Date: Sat, 28 Feb 2026 18:15:02 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] BPF libarena Development and
Message-ID: <aaOhJgqDmdGS+Jgs@pop-os.localdomain>
References: <DG5I0HN5PK5E.226I37YS7YY2P@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG5I0HN5PK5E.226I37YS7YY2P@etsalapatis.com>

On Tue, Feb 03, 2026 at 12:21:43PM -0500, Emil Tsalapatis wrote:
> Hello everyone,
> 
>     I'd like to propose a session on the BPF libarena library under
> development[1]. The details on how this library should be developed, 
> managed, and provided to users are still open. The session would let 
> us discuss those topics, along with sharing an overview of libarena 
> itself.
> 
> libarena is a collection of arena-based code that will live in 
> tools/testing/selftests/bpf/libarena and will provide a runtime 
> for arena-based programs. The library currently includes memory 
> allocators and an ASAN runtime for BPF arena memory, and will
> be expanded with arena-based implementations of data structures
> for development like B-trees, RB-trees, and heaps. The end result
> will look similar to the BPF arena library used by sched_ext[2].
> Users will statically link the arena library into their code at 
> compile time.

Interesting, I have prototyped similar concepts in KernelScript [1],
the biggest difference is that they are built into the language [2], like
how Python handles data structures naturally.

1. https://github.com/multikernel/kernelscript
2. https://github.com/multikernel/kernelscript/tree/linked_list

Hope this helps.

Regards,
Cong Wang
