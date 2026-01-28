Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10811C3F36
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560968; cv=pass; b=KUbHDuJdd0Y9lIuA6B7PSGGmlwbVcJAttL8Ih9A9lfiyu8AQChgqa8bwGChX5pVdgyyZllbddRYMeQ89Dvs0LNsista3m+hH55A+YqRqss/x7IH+8Q4v4XYetnAnp3Dq12QZFlRXPxsaCldSVKsyTBBnYcAXU2BoqDP0il5qjlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560968; c=relaxed/simple;
	bh=gL31am5fA8f3wM93YM4BbJljGUJzKppKO+zM3kHbhj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gySfoKVpukJcG36GLzDm6m3TMLTMRjWKvcjYycJHyAepiVTpTMa5P/JZYR/r5vJzdQazoBsGw84zMwM8srvo5MdTFwxOTqs0MuEs8bCr3iB7LbxgjNqK51y/huZJ1gD/uWQ4GDVBIYy4ueCHZ/tNWkvprDKSagXpYMh23tcrwVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSoJuW94; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSoJuW94"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43590777e22so3893780f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560965; cv=none;
        d=google.com; s=arc-20240605;
        b=JDkJKVdw86zHWnkda+V/J2HVqXKmKNnXFNjKEjQI0JCPuwQW5IV9P/SuPvLe0JTEit
         FM6Q9IJV6x00Tx3ZFYqE13xH0G9+lS+XjO+5jUiN+Os7WbKHX//ptGsTsAuPWx+jHun/
         u+TnZZ529eY0OH3FLeFPqRVQTntDRLX4rgE+mfR8luRpb+YSHYs5uHLgFwWT+RtyaX0y
         dWyqHonfO8O2Rqoj7g2EV5InmNOQQyHiTGoNG2uKkIzaFU1H4jT/MdT/bQyB8XLqLmRX
         nRKc/BLa1efhEznMCsVzj59+b7P8J6xZ4hKd1wDytg9ulyToHLbrG8h028zQDksc+YdR
         Af0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nn3ArxHOahZxRwyBSugO30Ohcz21j9kdphzBy2s9wBM=;
        fh=QFCKBz+bFHUY0exaAOG6K9Mhs13GMv1YfVf4ZOBvWic=;
        b=NH0xf9aFlY3+CEdHS6VbUzqkJ+UDyGIUnCnLuhBKrLihx1+VP8t3yZ+Ih6Ent5oQjS
         0Am5V4R1aTMmml6l6rI+ST0HIiaTFhxgI48+3GIHGhfUelyYMH2ktF+FlKii9sjZurjg
         pSbU6cmqR2CBpPxUi3xE7WeXvIeBv2avuN3KQtg0xnz6zB++mX4DkYl/rdz1VWA+oen8
         klXWRr1uUHgXidU2AmPrAaXB9fN5uoQtAa9Ct6d5BOnO/shw97O6JxJ9dESeK29xZlfA
         y/l8MXTTi84iAEVo6hISfBq6vMrNl+HGLWUiAFG9G5Sn8bBqijs1y83SenXo229EN/d6
         m1Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769560965; x=1770165765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nn3ArxHOahZxRwyBSugO30Ohcz21j9kdphzBy2s9wBM=;
        b=LSoJuW94Q7VcTteHcxjxljy9tqmFSiMLANX1Oe63FXG4uQSl1wx30zJJmmU05hpfjs
         AzbRRHnOTBdnHzhHgoBt3g6Lucm3vc70IsmtIz39QcjalKBcJQu/TJgX+GdNP1GmIHvM
         xC+F4lm4cyhc/yZ4YbP7hxkRt+0BdT++qcPtRdoJhqchB66WvT5bXrPXkI4aNYBpuSnX
         +CXzCAA51M2LbIp8i1VRCsxmKHpMXtcBzEyNiOdviZqrQTbqVckgmmPfG7fH4+hEEalm
         BnVSr1hIu25Vb4ktSU7IwLO8wEK/zK29/6WNn8jxzpSPMulQkU2/zMAwB/YgjmtwURn3
         9lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560965; x=1770165765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn3ArxHOahZxRwyBSugO30Ohcz21j9kdphzBy2s9wBM=;
        b=WSh/b/xruTNA54FEdvCYpr8xzqMCjdOpyegnMXjIhyI7wz9mHtkSxybV5QRB2jykto
         BTQXWEjeUkAZ+WhnU43RMWCWgsk9Ewz8MUTnaAyr56ABP/HramZ7+PeKZzUFRJNVb3Ek
         cURFPtXZq8002q2nKZMAhoej6pDPy1R62q4ajuXnIDkvlSrS4Lzi1RLu+wS7EwSJslUR
         gJvWr8ftylnmHSOj0tT+OA3lZU+FgMx8rWRnNV43rbierLpL7yqCgQbBLYOvmzhODvgP
         j/TwTxXf1gJHo2Yis8eGoGXyClSrBWsr2sIAdXHrxhO97VVIBOdSa9UqHzIV/SO/v9TN
         uMPA==
X-Gm-Message-State: AOJu0YypoFjp0Vbbrheb3lcbf1PvTkBalgcMfAwoVGnTmBed9oFlmS+n
	Qx6TdqIdkLvK7vz7+2fs0cOx71l3rVV9CQuXvvx/TSJJrPml8YScBxoYgkwFiNdNmvkxyxTh2bg
	FGXdGFij7nAflIDdVo8Y1+k/5HCYm4DdVTF1k
X-Gm-Gg: AZuq6aIqAoAT4Zlw4G7QNyMQ80X0J+eOCmxiqDWFpyB1ij3Fs7EvbyR/jo3ZXWL1CrQ
	xKqTSq84/9EDfPpYqgZa91Drk1F7i1i+e2jww6nHOaGNqFnPgXtdlqkZ0/jbq8yxOct0/VTLwnL
	GKWILEbhWqWOZLF2XFv7NAofmbwy81GLrzZktT7lZkFaZhgoFa2+FaJ0Ar8waHUhuywAHfrqdrB
	2F0dQ/A1Jja2ama6RV7SHFcCfqHSp+5wAnPmpW1eUYT9U471VnH+/aMXqoAsF8bAh7qNPZkP+YT
	5QANOwo9rQQhy3/kWWz4/DEwX1Kt
X-Received: by 2002:a05:6000:4381:b0:435:ad52:31d9 with SMTP id
 ffacd0b85a97d-435dd086069mr4756764f8f.28.1769560964801; Tue, 27 Jan 2026
 16:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-6-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-6-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 01:42:08 +0100
X-Gm-Features: AZwV_Qh8vklqI6X_N2S2IngEeambJ8teX5g9K-gnlBgMYxX3hlO4Mv27pu_UBSA
Message-ID: <CAP01T75+BoQfQN=47NhYYviZttjCPb_CXNpa=DUC0=xSvdNZdA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] selftests: bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, etsal@meta.com, 
	ihor.solodrai@linux.dev, martin.lau@kernel.org, puranjay@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 19:16, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add initial code for an arena-based BPF library. The current commit
> introduces a test runner and Makefile for the library. Library code
> can be added just by including the source file in the library's src/
> subdirectory. Future commits will introduce the library code itself.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---

I tried running the tests, but didn't see any splat in BPF stdout or stderr.
Based on the tests I expected to see something.
Not sure whether I am doing something wrong (I'm using clang from LLVM tip).

I am also wondering whether having this separate runner is the right way to go.
Instead, we should be testing properly whether ASAN splat is generated
like stream stack traces are tested.
So it would make more sense to integrate the selftests for all
allocators in test_progs infra (and use regex in __stdout/__stderr
tags).
You can adjust the makefile to only compile asan variants for specific tests.

Also, throughout tests, some errors or assertions are emitted through
bpf_printk. It would probably be better to emit everything in streams.

>  [...]
