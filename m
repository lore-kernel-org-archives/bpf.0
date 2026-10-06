Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F449BD8A
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305593; cv=none; b=J3eMp/exqpHQo30MdiPUN94th5XShKYoGdOSGqu3hdWmHfJoAb3g5lkJV/Klv9w8zcJy/cQtpsQ4WEqRLETbT0Dzl+Wnd47NRCUUnMmnCj2jvSTTZLiAOU1eRvoHS9FTs2eJiY//EKtNjD9SftWeX73fdBgqZs0TdlkfBR/6iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305593; c=relaxed/simple;
	bh=fzs4zi1Ry1ShGXrMsOGxgv03OAjjFI08Ucvqe8lNRlw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=HUABzP0zDzs5E1oM52jCtXnohXNmP2leGIsrREX7wiQG+2eRiTivV/ELkrcKLkovXEAWyd5nScqFk8y+Xa9H+VKp5rm77lSz9d2J89sSWTOoC5kEU+AMEbWSA+8GQkL6uQfScXR8ECMLe+b5QfjRc59RmE4T6jjzQteczK6L/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1DmBCwc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1DmBCwc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd9cbb661bso7977135ad.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305591; x=1791910391; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fzs4zi1Ry1ShGXrMsOGxgv03OAjjFI08Ucvqe8lNRlw=;
        b=Q1DmBCwceMjENM2M4c3E+oaoKcxG5VKUAYxClvY71fmq2PDR07rUZKDK+B+KCwQP/n
         CVghClrmLuftGg64PtUIUlM66Pz6swPHWsDG4KGdyfOsMb5CmrfMjR6PqCems/4y3pFV
         nfOtCESPYENpHp291xQXuhyOlOOmsBDk2pDaufkXRBBXSOLBzA8y8wG14Fhb8+EAvohH
         E7Gr4kVzUGtlTawFimy/wwJ58iVxzWhkEb7KtLIQmtlrDhTu6oK+Qcqq2AXyNovkQN/g
         iNlqPTbx9bua51j3Yc3A6VQn+BMscQijDpVqOx2cskqkwgGuC7+fOfcW++gMBCATAnAr
         dsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305591; x=1791910391;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzs4zi1Ry1ShGXrMsOGxgv03OAjjFI08Ucvqe8lNRlw=;
        b=fhAzGSXcc65xEVsx5I3if7FFjQWFnS1y+ufT7I+c693kbqtivrg3X5IEW7WhS88RuD
         3cS+UQgfkzEkTWGEWZXHGhkQk6svLAkAg+tTCYHaUozQS3pFbHijshBMnKFd/mqBDg3z
         t6ZduITF75O6nZ861i2tep9a85fRJAmG0hWYsMF8llWUtOkCc8F5DxLrnVGUDc9dWZDW
         DzqvgFeiNuJEknZnL953esCdKdwZIEK+kDPpa/VccSd5PQ/TW013JeKhCtaUIqVMQn46
         RwFI9jQtDY0Lbnd53Hk/cXxWCVZ0zdLjPJLxIsP5bt7z200KqGhqe998rFyhEr6sFzDS
         tsqg==
X-Forwarded-Encrypted: i=1; AKwUvBw/KigdooObIRB7vzTHxesXih2q5rNVAAuV3QJRw3waL1bBSZNZCzqSaWggj/c08pkK8pM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNbynVn5uMAgyEff+JPRXaOXs+9prPX1exeNd7l4i+4w24tr6l
	+1/SmMA2lg4XVVM7XXBqu2v6tOSInGK19yt539412q9EEfvx7vYwtZle
X-Gm-Gg: AYBFou1OX4Gf5jGv9KOc0y5PewPCK8m1b/TFlVyGqSULKlyssaOCZs3S/J8G2DTaDKy
	AB8KnSKxlyYHLcBnYGCsjf7aL3XpEy0ezQpBkFyNGwMppWjUpnuuyOjPNhYNBwoHuEvlxi3eo1C
	6AV1ryf6/d2TdWDdRCDVhkrm0EvCpXIAaPmyQEQXJ4dFqaIZ+Sgi9VtCEGFVGppbWhricDgcLl8
	F6dmfbz6Zy0+TCy9mmYLvgSnJk8zQeCML7jKt0F543RE1S9WaQ2i8GLFP0YfFPfghLp3z3ovyHL
	4mLXE+ZqfVSwb+vXogHyVyfTglfc2x2Mbbv/6sdeBj4wx/6K4MqJ/szRm3Sck5wiXF9Cv1A/1CO
	KVB0iCXXLTo3TW5pkXgh1rrwZzG4uDwBkEIv0TV/26MGV6MDrciHG76CbV0wd0XScqOk0U1uSnM
	F3iSwvsoKEVIHgrlUCXPi23ehiviaKmvoBq8qouVjX/7CwwP9tfXc/j5ItJv4J4+W4NFCBBkXSs
	kUuR5w8WIjgAd7+r7BOEeKNxxuwW90tfS6PTVOyJQV2zVKg4HF4ZG0JUN5oxtPBeYHuYKead0ep
	hdg=
X-Received: by 2002:a17:903:3c67:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2e60038a982mr535995ad.14.1791305590540;
        Tue, 06 Oct 2026 09:53:10 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5ff92069esm638705ad.83.2026.10.06.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 09:53:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 16:53:09 +0000
Message-Id: <DLXWU3H4P99Q.1RJN2ALJ3JTAX@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 23/43] bpf: add a min-heap for ordered
 analysis worklists
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-23-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com> <20261004-scev-minimal-rebase-v2-23-f6254e29fdf2@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Oct 04, 2026 at 06:38 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> SCEV needs to process pending basic blocks in reverse postorder.
> Provide a small integer min-heap whose comparator can order instruction
> indices by their CFG ranks.

Why not include/linux/min_heap.h ?
less() there takes 'void *args'.
worklist_push() checks discovered[] first, so an insn is pushed once
per loop. prog->len ints allocated in bpf_init_scev() are enough
and the push cannot fail.
