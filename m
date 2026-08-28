Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B439A071
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889058; cv=none; b=VHoQlpAb4pMT4z6QZX587Y+rK6160gazTUMEFLKiM0Ui7j0XQLwgcmNEfGlYZzW6ODG7HqAjyMXroDyqu2gNOENprnXqs0n1FGbvT6lHmuMCHn8sIzAb3jWsCM5bkTJGg9tqnPkgKyaTqwgFLAmVyTi00UsnOjQrdFrMpxy3rBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889058; c=relaxed/simple;
	bh=qxXuDSETb1QGvICRb6JF6QpQpSR+Hex0aJPS9wGqpCo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fM8PKyQpdOQcnDCQGZjnibeE6n9JHfVhDIVQwPBzKkOgwjE+kJbzfhG4GKVpmr1G6Lu8CCUfESdJjli2hvNuxXXYx7tSdv7p8fUHvqjEySZXkkSMt9o5JU2Z5jgrta+qHuvWH6/guNotW3yfw6qZNK17tRGtH6M2n7a9eFy+0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu0MssnI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu0MssnI"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1386977a12.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 20:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889053; x=1788493853; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x4Wo3AFVWJoN6NjZ+CjXyOXScjwk81QQP/wB9zVSLpE=;
        b=Iu0MssnIdYs5oBK61RGMgLHv6pbQmm0G6nj+OX53oQc2QIqBIWgKGMStsPhVAIZXCZ
         6KIXJtU1ggJmTlrObkqAuCwZn5yEFW5irkp2NNYE2E3fib97Y+lIbq35w47CbNm9LQNH
         1Pplh4AsO8hmM6kJsbIPymf1lYDt+de/jqC+BFGVjCAnzWzped3LlncDTU27kLDQSRqT
         6189Df9kTOUSqqMjLd3TU9N7vd8l5YdhqVTr/qJQ5EPDza1KH1h/GBp++7QTeUrcSBhS
         TVgjBixy9VNwEKh5VZ/5DOayOPA26D8vPLHLIBqZoH4yolHFkjNhhuuJqAk2P7qJumAo
         zfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889053; x=1788493853;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4Wo3AFVWJoN6NjZ+CjXyOXScjwk81QQP/wB9zVSLpE=;
        b=e6Ekbr60rBqIBF00eJefwszi6PrgqjObK+77J+xleGTg6dZix/rhDAvoHUe4SGSo+z
         1mjOOnk1U4casQFlG+U+s5G4zGBvYvXIcQ7LI3ma2ik5fM4oZibuDpF7efVxVR0LGWFs
         dQWjCYxgKTIxmaCLBpsEfUg/cpbkRWfvIC8PfiKDdapzLOGfSGvcl1vEkCERcAzptMZC
         B80XupMLzdbHlMPyG4K+aWZ0+7vu2JNaS5ggqn6o7Ttsk0D0h8MA6VL7sd6DCsgfw/nD
         aBOHZXfUOL84F/3BnoIWIDEbSzxeOA+APzzj65fZyXl/A7yDiUxhnymnf3u9TubK1vV4
         jMnw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6EhMxVE+v3joBsW6ezFGEtyJNwJWexHtwDHUh4Wu/V4jMUMbfDrTuVvPg4tsJlUffG4c=@vger.kernel.org
X-Gm-Message-State: AFuF++lnGLthK5GJoiUggZBBH1GZwLBzi4SEtPUTfBphEgvImAJLYp0r
	SNLpw4oX8/IpJev55hNeTez/NOf/ClqxHlxtl8p0QyD5yuN6u6nnf6Vn
X-Gm-Gg: AR+sD12lC53drf2G+PLSfhMnwTuy7k3bHd2AoQnDhLlDCDSmMzaOJ4Z4kCLwgo3SR5P
	FNWqbkhfR8SuHfzOIuhJx0oeFPjXRWKsLQrxbLX7pi0gBI9g1iNh4a2vCP2eK3tPGshipBGfSen
	4D1qzeykLhdCRTPbPZxLG9MQzYtwBvyad941vTFVeA6nqxzNg9jbL7+iuc0dYJRU4ZVBMH8PAK8
	bn09SBZn5zTFBj4iE+giQpVlX93dWKroR3g6v3+zgLFPMbJpHT1CzsB02l+yA3bLR90t/cgJAdp
	ATjknF/gxiwC9dX/BItQ7azwQRCKEdsWeukfc4ExeLA2dg87Eqk8tdi95QdMvHxaoi3haUHu1HS
	KPTSz9ObS4dfMYfMNdQXQ0esWQPzSlKW5h+9VIBVPAN/N1g1+L6fhQA/KcmegrUvrk9n3EVc+J7
	DrmrqLYFN1Q2H1zz4GQQgQDLZVeUtFx6pvxR5llFygPnxdGk0QD1Au65hTXwwMS5/c4Q==
X-Received: by 2002:a17:90b:5484:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-3969bc0223emr15330087a91.10.1787889053319;
        Thu, 27 Aug 2026 20:50:53 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0e0e67dsm1659184c88.15.2026.08.27.20.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] binfmt_misc: only let punctuation delimit a
 register string
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
Date: Thu, 27 Aug 2026 20:50:28 -0700
Message-Id: <178788902858.3236768.15019506644956689303.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 17:55:45 +0200, Christian Brauner <brauner@kernel.org> wrote:
> [...]
>  tools/testing/selftests/exec/Makefile            |   4 +
>  tools/testing/selftests/exec/binfmt_misc_delim.c | 127 +++++++++++++++++++++++
>  4 files changed, 143 insertions(+), 3 deletions(-)
> ---
> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
> change-id: 20260810-work-binfmt_misc-delim-83f62cbcfe23

Makes sense.
I think it's still pretty accepting when you consider all the
punctuation characeters even allowed :)

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
