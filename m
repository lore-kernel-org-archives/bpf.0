Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FA33D6D8
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958360; cv=none; b=bVXKuV9S4Dwl2p7qdK48w2fIoqE2fnJ4x8zVQ2GfMd1MsgVny2F4s1AS8V7qaDHZ9KWoI3F14ZY753u9zYyGNz7QR1bfLMj1d7HZHZ8rIbqnsKxkWHQL1RGaCEfdFHY3T8g+jIq825rQJr3MRr/Hi1QV1MRFq3GuTZw98rCXatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958360; c=relaxed/simple;
	bh=UyZOZuyRlMt3+ip0WlUfEQ2nBW08rltWdK8cjbw87Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xw+KKFya0vuLulO5Tovkeg9VZLopqfuTLWs+wPT9dZb/zrF2bPk6TlQd0BLi3MBhTEoFOulQI+qEfCAa3kBU4Y68rlpOp4A2oRWUc/vPFo3ribnUWheXLE6soyFL/Hlw2DyHNlNuK60StH7rnQpyJOku9IbaKn0+FsAvqdGe5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=aeKKAanc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="aeKKAanc"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dca4debedaso1088992a34.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778958358; x=1779563158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZc4kj/8128oLJ3m8eOOQSX4eFeWKel+YW2aiCdJSZ4=;
        b=aeKKAanch01DJJc5tIz0fzxjvag9DEngY3FNU7E9eDpSn/sBspxJWfasn1KZF0D2VF
         37HihApVcpXyNRrtWWiVqHFHFzUo4oVu/R1FGbdgQQkYByDscC9K0mry3LZVH4leAIk+
         MALH1cq1akwqRTj2XnZenk462Ps4iDmE5A3EseRoF9GJSttOp9ucA70Z/jGm7H1DSbmv
         6Xk40sTPSaP1r9y7PBwNMgh4a3mL1Vz50DXh3U8txmwWkRnu2uM4qEGrc/M0KNT2IOlD
         8BrwxhKOkuk1kl/h7G3WY1pUToYlZtJdJ3BLI3YBCdXmUJtkQ4LtiOOJzWyuMjt1iZ89
         AuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958358; x=1779563158;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZc4kj/8128oLJ3m8eOOQSX4eFeWKel+YW2aiCdJSZ4=;
        b=dmuICPcnCtqMXPw6X5Cf1alh+ExS+ieVFjC4mEVCuG8N/V5JrW8QJ86sCunkLdao7I
         9IhrNByKAytfHaOZWrYHAH6KcahpTzwGvCXgqws9MzKt4Ap9RtvUTN0oDdt3Qkf6reIe
         vpAkBxpASHJC9jo76c5ANxhDxAVTrXSGmnBd0nhDatlM7dsiPRETc7WdLkwb2sosHcr9
         YVSVXQDTYQqZNqmvklTqotiiLsqPT67uzO6Yfq+YVKQ209859SPEECxTz0hSkxTZEA98
         +pjCBgmc4Yi7cdnoCw9h0yvso757dLmK6K9aUBKEZ4q6Acsb66rTQ+r2bKFCzxH4SOiv
         vhsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NZNSXV5fxDPiWSL0GSzCuFeuQi2bXuc2xIaRWgtljKylCmn9i2aJjYW31OF7sDqQcGyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygt3tnYndhEu040K93RX5NHEuIwwoc5lDAp+sgLP+WiHDbd7vi
	vP+oFGginnuBcwyAhC2N+UBpLvHkYsi1rE19EgcR9P+dVEhSkohloaLYu0d0xwmQu7g=
X-Gm-Gg: Acq92OGx7s3y0/cx3C5VRXCOv8TMEjPfz9neCrms1wgp1dS9IiZ5Ug3rVCxwDC7PkvB
	ePmVkI7jZwyQILzQFS4yefjgbgqYkCbw5e+8CNDfHL/it4jEGX5BP5CYU2bXQOthbLMSwq1joCH
	FVaL8Mnismg1LTw0zh0Vfu63HEAPuT2IlQ0KPjchQG36JoYISdj3H+MYyGjOh8AARKtocqSepBi
	BS87K+k00C0kHuhrQRzA29eGakToRhLr7SrKtVt8Ml/w+vDZFjYNOc0cVueMB2plDJuTVNNfVwN
	57+ep0jwSGfz4c0DfYzJ1EklStR8qcvMyXKzAw/fSwAc+P4YWNHEdbqDxYzUr07h+8grHGBgLuu
	66YEGn1/HjIOwD3FIP1uMFpb23QgC+LrZCK4EIUXLxwa/c8yXU6BAgxB6e6LoQsNHY5sIewklo+
	Y66qq85ZIJmNfgyfIe4vPcZqnnZEkeOJO4Mh2VsGJL4Hyzjc0XaJDuWlhqZBl/wNHPmi/Zn2xjD
	7CJ
X-Received: by 2002:a05:6830:4704:b0:7dc:e090:68a with SMTP id 46e09a7af769-7e4de651649mr6339319a34.0.1778958358300;
        Sat, 16 May 2026 12:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd08ccsm4023092a34.17.2026.05.16.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:05:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Li Zetao <lizetao1@huawei.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260515145812.1241925-1-michael.bommarito@gmail.com>
References: <20260515145812.1241925-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH] io_uring: propagate array_index_nospec opcode into
 req->opcode
Message-Id: <177895835722.925638.5480075990608035864.b4-ty@b4>
Date: Sat, 16 May 2026 13:05:57 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 15 May 2026 10:58:11 -0400, Michael Bommarito wrote:
> Commit 1e988c3fe126 ("io_uring: prevent opcode speculation") added
> array_index_nospec() to the local opcode in io_init_req(), but the
> sanitised value is not written back to req->opcode.  The
> unconditional write at the top of io_init_req() stores the raw byte
> into the persistent field; the success path of the bounds check
> leaves it unchanged, and downstream consumers read the raw value.
> 
> [...]

Applied, thanks!

[1/1] io_uring: propagate array_index_nospec opcode into req->opcode
      (no commit info)

Best regards,
-- 
Jens Axboe



