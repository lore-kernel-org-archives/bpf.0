Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153454CB8DF
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473711; cv=none; b=NmRIyglUwJEjbRJ0tUFVLkpMSIWxHUCCJUfiHJje+eClOSwvv8GC9CA3za346qh7O+0dC9xVTfCCIpHr8RHDvdG6Hp0cjS+0nExnnh5tkU+XXLiMQ5f6r9PpdEu4Epx+w6LAKxzAKfvfqX8mdy+8oW7mmAvQg93lt08O8GFdzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473711; c=relaxed/simple;
	bh=oe4Um/bJX7+Anuru9IS6WY46d5H5oMaKYuUK1rwpoC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk4/4p7lKD/qljulm4rycUyheqK2Rl+ek4PRz0Z7pO16UFdte4CqoAT1BezBt6qGDSEhky06dcYSHPL5Xfmz0TvntF33QkFD8qtiFoavMIKxVs6lzxkwmLOYwd46/RRBYnxkx3K4aWYT64yDC1kSKcPFPX0mMsNtiXs1nfkHZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+nqLtv1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+nqLtv1"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso353809a91.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788473709; x=1789078509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oe4Um/bJX7+Anuru9IS6WY46d5H5oMaKYuUK1rwpoC8=;
        b=Z+nqLtv1e2gVvHC9EZrQBuvgqxGeyNJikuFiX1cVh0K2L+mtV6lh7AQX94jYjsCIwN
         zBMd7J+qzEp9Qj7tcyCVF6YNaMgTmjg01s4w7VBcJxB3jw9WS6TE2rWN6tm2+rlxDPD+
         LsNCeZbcBpGhxnTUifzhht71f74ewa66VdOh3a3Yzpz9mLFM9r4vawNYbeddFy8nQZus
         tQumT9xySV0kWRBfEV+/ypjOiRjTFHUnPi8QsHJGbgfl44cqYR2FGCMSBfJK/4GSFsVn
         sQofNCdxjA4Den1VPVzdl3XEHF2kbVTufnta07t9l2Hi/wtWNIuXKQzjy/L647cdCJ4+
         oJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788473709; x=1789078509;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oe4Um/bJX7+Anuru9IS6WY46d5H5oMaKYuUK1rwpoC8=;
        b=KDJmgJpnpVLaJTfWujUW8+yMWyVeEeD2PfQ+FWQePg2O3pjDcNplSfJl1sTWLh40S8
         RKdYdkh1SaYBQmmoCotKWS3qoRfpCHc5gHJ5aU4J+S+sk7nt0mbcaeWTj0UmbZwVrAtY
         Nug8Q2Wdt7HK2WNw/rnBlKFWh8vGbYTLrO4NPypV8Mn+jZJv/D9syF35zCPaSIyixLMV
         ALHdjDMTKpowk2W8f7y7YmeNkhiLNFHJ/T3kNiUdK0KLeF4cZENo7AuoXF+3jRIlXc8S
         hxyTmqKtj6ZPvvSla3HX5x9NPF278g+uOgbU0TEHOSlywKdWAqXB6m3oX73OznKIWmeT
         y21g==
X-Forwarded-Encrypted: i=1; AKwUvByqAfMYSsc/EszobVEz4x91mlQBg8OmDHfm8BjBTyuVtyyF/vRIraZIDfl4rTtrswTFEfk=@vger.kernel.org
X-Gm-Message-State: AFuF++mwWtN7O2DGt4NIBo/j9r5I6DW4QjH3prykvUgRh/yZhiTV69c4
	3rYRTOIUZ+a3tLE4j89ZhHQ5fUnFcWkY63pe5RqOGlLXbCuY/yuGa5HO
X-Gm-Gg: AYBFou2YhruyiHrzs+Gg8k53wRBwyl1/KkrcLo5EeOYGUDqIAPMWpDPe7mBg6/I+bTI
	sA9k1f0aaPelHeS50TdPbGjFttXr5X8INo812VFjk68/xiaD8maID5tRyD7NOMyX4IwuLqgXltP
	e57GxArJ0w4SeyqqfgTGTbYMKC+UmGGshuzeDi/lsFUFiU96Lm24pXyqd+AuMZFW81fuXaa8U58
	uCKU8MYo/ead7rQbpsQcpXP5KFjXI4yaev6yUGx9QbUqeuI20LraR3qTIe8MW4AqHH9KsNk+5gB
	IwD4JUQnpw+VWiNpBxqqSV2zC7Z8pwWWu6bBuXPWw1E+ubWpSJHv0TNRpcpobpx1NWqgtDIgoVM
	3vj9fxCB4QVY7g5Q/YiloNBEeh4/5EKQe74SdjQVrofpTDHoZ2ECduY6RldA/e8yDXcy67n9hBZ
	JixAlQw/TmP9aphxmNJi11ujPu4eoWn/6VbLhhsAiZ4zklSv6vro2lyiOnb+QaiUEsIh/4MmvKF
	apFASUJlrqoqY6GywO8u25sr1fqcw8wP772i6yRGIueuQ==
X-Received: by 2002:a17:90b:3d89:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39b262167e7mr2409924a91.22.1788473708901;
        Thu, 03 Sep 2026 15:15:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe3c:fb36:dc7c:5b5? ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm1657910eec.0.2026.09.03.15.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:15:08 -0700 (PDT)
Message-ID: <f8bce8fab45388b3145eb069bca073c71db04973.camel@gmail.com>
Subject: Re: [PATCH bpf v1 3/8] bpf: Mark bpf_btf_find_by_name_kind() as
 sleepable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,  Nicholas
 Carlini	 <npc@anthropic.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 03 Sep 2026 15:15:06 -0700
In-Reply-To: <20260903214758.2727663-4-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
	 <20260903214758.2727663-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-03 at 23:47 +0200, Kumar Kartikeya Dwivedi wrote:
> When bpf_btf_find_by_name_kind() finds a type in module BTF, it
> returns a new BTF object fd through __btf_new_fd(). This reaches
> anon_inode_getfd(), which can sleep while allocating or expanding the
> current task fd table.
>=20
> The helper prototype does not set might_sleep, so the verifier allows
> the helper in non-sleepable contexts such as BPF timer callbacks. The
> fd allocation can then sleep in softirq context and install the fd into
> the interrupted task.
>=20
> Mark the helper as sleepable. This preserves calls from the main body
> of a sleepable syscall program while rejecting calls from its
> non-sleepable regions.
>=20
> Fixes: 3d78417b60fb ("bpf: Add bpf_btf_find_by_name_kind() helper.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/bpf/20260903155150.D57251F000E9@smtp.kernel=
.org
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
