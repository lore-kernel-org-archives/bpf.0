Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FB27F4F5
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349232; cv=none; b=WMBPzMsUSl9TlBTOQhdhBrkBz7VYRZJmPXFKe9VcBGTX7ezWbX2wr/bnK5Ss1jMgbeuKra3j+UY+V4juiYbKP+jkxw7wpYajnSaW6s3+x+S6oav/OHKYZYQYh/5CMvn3aTGwJr7jTDZR5reVmkRIphb7h0MEp9Z6zBB8BHy2mx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349232; c=relaxed/simple;
	bh=vRdqAJy7vcRa6nIl+Ykkw3JIzh0pljguy21zEtESKGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Fxhgi1OTdYcunL9OJlhxmqwSikOx2AN0ASgb3KlEjBMzzogRNli9IVtfehxzm+2G6DRaMhzq53J0ADGDCjY9zz4hTfzrvdP+1BpZjhmQZLyiDncpH62x6QObhGnazmHXC3zJYCvxIqGIcj3uHkC4/2JX77hWLEi/pv71KsSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0SX42UR; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0SX42UR"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c85893bce34so763944a12.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349231; x=1781954031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRdqAJy7vcRa6nIl+Ykkw3JIzh0pljguy21zEtESKGI=;
        b=A0SX42UR+dr7i20KCcjqhXciUWycVzi5MlzodH8DbOmmleV817AdZswSMxPVZN6imW
         LIFjjfAdMJLwN9MKcYQUC2F/9amclGu0dZsj3zb6HLR6BKMcU7/vF1ZlHZvOTgOfGwDQ
         9bdSHEsvIA3pD6njIU23RNVmMNJYFJpgdJgHv+vQJVQii2BKsd0GzkycmjhJeqWQDgkP
         ZkZtEy2jods9MPfyey4wfamFpU76sojA09PH2sekmT9yf6RQ65mHjjHPdO7lv0eyrEJD
         B2OBxeoM6oOV4QFOKfUhBRtpe4K7VMOraaLPOChkfSZKQZ2Ff0ipWutuDHlGHP0brCT5
         1EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349231; x=1781954031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vRdqAJy7vcRa6nIl+Ykkw3JIzh0pljguy21zEtESKGI=;
        b=CU7cc01UIhrn7nC6zjji677zzv2rvvOuBhfTw/gKGxBz5uJcWaq5tPYMmFz3rBVGdx
         WeVb8ZPEhM2xwx8esDbqX2Ujm3qM8Dg4zlPkHa85MFZE+xykl7KeNbkHSpE9OuqdrGll
         q6NAF80YI5wWQLowEzcM3mp6Ny3ytsENkM2wwHcNcmkflmegcdNEi7fFFXKfCT9Aeeqc
         gfiDItEfu0O7aEDA4lUG/zAeRVhbsXP7cxz+Y61UfqPN2kl95Tm2Ou537p6g2OnJ2xGu
         M66jMq5WpNkQAi4OSBYauNyGX4uWu2jykjnmfRk6lsGju4aiXtlcPnB19Lfc/qvgQXrR
         9nKA==
X-Forwarded-Encrypted: i=1; AFNElJ9hJ53tiahxWtbnb2rp9eY/s/pKr6/Lf7utvjfnzx0xdsqHpgpgX08A29I4xTmfrekjdU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4y4Gf4M6eRlyuKKHe6l1zY/mwMokvR9tgcu8b8flkFMNqxea
	oOztMTq3GNxaN6La6WIVjQI8XThlQB/5JRIEf+nC4QnWzul/28AzeQzZ
X-Gm-Gg: Acq92OHnSG3lW3bw2SeW2u02KZRonuuUGnX3b/k+mnkppec9aGVHRbdbX/lDpXCvpXg
	LMvO99I+8S78hz4/VFWgHsOfzE/qNuJQ496m7A6cv+fX6RrAYaIdYVOaPzMAv+THmOw0A7WhVFm
	KYxmsKLr725RUMlvExfbuaXTJBjqT9Mlu5dfI9whexVVIO1/MJik1qgcSdsF/yY9VszkoJVgi5e
	4BadbdvXhtIqPZnggdEZDRIzfLVnOvUWWqL77+ug5ikC3jLJTNSFPhrXcU7du3F3Hvcfr2FF9CQ
	LroyCzAEKh4BUHqaJuK6GAjxPzfeqRZ0bpwftB8SqtUyTf+yjzuvku+Lzgs7YhCHM8CRVd9WVwb
	DAkT8H9yrhgaxMcEy2eL/56wpGI4DDR9Zo4u5qEf3azc5uMzJNfQB75Qv7CbLS/UIFVAKjB0PWT
	93PN6iEBU2y9lY2p2jaA==
X-Received: by 2002:a05:6a00:1a87:b0:835:3d5e:1dd3 with SMTP id d2e1a72fcca58-844e1ab2741mr3547181b3a.42.1781349231058;
        Sat, 13 Jun 2026 04:13:51 -0700 (PDT)
Received: from laptop ([175.204.13.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm4759876b3a.59.2026.06.13.04.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:13:50 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack reads
Date: Sat, 13 Jun 2026 20:13:46 +0900
Message-ID: <20260613111346.271837-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DJ6MABD6AW71.4585Y3MKTIGC@etsalapatis.com>
References: <DJ6MABD6AW71.4585Y3MKTIGC@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 07:43:12PM -0400, Emil Tsalapatis wrote:
> Correctness of the patch aside, is this a problem ever see in real
> programs? Unless I'm missing something this is extra complexity in the
> verifier to address a theoretical possibility.

I don't have a confirmed deployed-program regression at this point, so I
will not present this as a production regression.

I did check whether the pattern is reachable from normal C codegen. A
small helper-based BPF C reproducer is lowered by clang 22.1.6 at both
-O2 and -O3 into the spilled scalar-zero plus variable-offset stack byte
load pattern. The unpatched verifier rejects that object after the loaded
byte becomes imprecise, while the patched verifier keeps the zero fact and
accepts it.

Given that, I changed the target from bpf to bpf-next for v2 and added
this context to both the cover letter and the 1/2 commit message.

Thanks,
Woojin
