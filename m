Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B653644C7
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778761; cv=none; b=fJK5IFpYpH/wpX13jTZghRZJTQ3X7s29XgSYsZjLkeaEDT8/bb93GCHq0sqKyCJ2d1XGbdPNdKKpzqO+fNVs+fma9I+dRE72n0fby1FcK8ZsyK8hs1KANNevR53NLgKoEdnpcGzwO4jkQec/8OsHNsdueF/PRqeNnTWUNbpnKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778761; c=relaxed/simple;
	bh=NDGDfJcvHQY/dLknd5LZMdxKuXfhjbJh2t1x5x/SpJI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tQ2bqKRoBJ68XGPANWxe/LS1yeBKlHAiGd41BxVkn4BBR1E2+vo/1E6rQ/n5ddRgBXPauOz9iWZM2fmzmLo/kk+E0nArMRlocrVjkaz9n1ucRUJvtIibM1RaQupEqTAcRyK2J2Q6vcIy1h6V5GxydxYHLFGkRU4CgsSn9Zkap7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyRF5MBg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyRF5MBg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848643382fcso168605b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778759; x=1785383559; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JnOvPtms1RLQR9UWnggpXMwfANAdvGkfvfRA3Dni8Io=;
        b=nyRF5MBgmPygt30iC3aB4MM+TlTj0WfAK9Vhu4FbM7FaQV4yL7vF1xS5bC2bmI8zxR
         EhGN/bmkMRgdfYHi/h1A7+qrGdEmOKssMicIttdgyN21+WGSw9viQdnDEMZ5n9si4a53
         4dnz+WGAIZL0sC1r1Kg31DfvpCadIX62SxoR+nzdHP/uIHtkHy0uA35Gx+L6XpYQ0rH4
         VVSRjfGCiCz8w48wpHhR360Xrlj0SxAwyYPlb70kuTDsALQkLKxtvCT3Ji+m3xUsCR3n
         1Vec4QAu91W+fFSmDms3FgIh4kKXq6UYqWzjCHsEyygHu7AsrKTN5KC8S41fYCY4DsD2
         yddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778759; x=1785383559;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnOvPtms1RLQR9UWnggpXMwfANAdvGkfvfRA3Dni8Io=;
        b=m23fNsD1yPCKIwCc6vJuwSlkEHlrTAuSNnN/PNmFMaKW/aLvjyn8zuzfxT/HGb2G24
         dSXQ6NIcFCzQxYYjNz7OUj6hM4Tdvm6sv+ZK4MGimL2y24Gxr1LABNfn6aUHQoM+aGnq
         cvxO6dSdmUPUdwo30NmW7vHxdYGBjkhKBIYs+e7zhTkGCPBRTP+xwiWoSsBUGprGZmm7
         Y+Y8OOzNaKGORIfpSIiGJUgdBxB81NuUYGn2Lhnd5pNwbP7Zk8ZDpbDxKtKMtO6cR/HZ
         6dZqbY9x6RkUirO1xH+xJVMbWiJlaBVCV02T4m9MmQMkS/utz1x/a8KQA/yKaDhFAegS
         aiNg==
X-Forwarded-Encrypted: i=1; AHgh+RpY7OCKkIwFYWjfSWiIHz0uJoNPpyDbVw8KBHnTQ2qTBzvpZqzBNIpaFUhIjQeFvnxKRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0YXmZ9alF/QGSZ29AjW6/gZlvt5ffXnn4e39hKlY7J4t29lD
	8pzthFDbJNvbsOJzKSKvu+gqkcwvlRgSOLZp9E4zFEMmzm9DeTAGusBg
X-Gm-Gg: AR+sD12ox7FLwDTTKu+sXVfP3d0xWXJxOHjBopsEbd7sUAItsaGOY2ribVY0Q/UpGdx
	2mVHXwYxKoAY+v4ks9mJ2SHuYei8SORT3jMK5JIuuyqoHbMC3tgTEWGdMK2pYp6ssC409UH+TsV
	xlTJVwXnRsXc5XhLSJH4vAR3ftaNj1F5EWoIrPtFuwL3xEZTEJDQTf6847Aa3RrDkEsOCEC8cOZ
	Z3GcqwFbz0tgPqqTIE4573ngV+5orKo74ar+2iNsk4QSVHdGzpiHErdZdZ6HAigkIguxl/UnqRs
	YM09S0alELslUMTDsWkAogHNNFduccuM0bChl8ksCtqBio75WEdQPsRjctO2CahQlwa7nUxIrzB
	nhLGWQdartcIP71Rn6Lstb1dl4Jt3en9abyq/M0npVar2POsdNW+fROPsqQQ/ljaKhiODese4jK
	7wwyAAuQ==
X-Received: by 2002:a05:6a21:2d4b:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3c44b1c86a1mr1373005637.46.1784778759161;
        Wed, 22 Jul 2026 20:52:39 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 04/21] binfmt_misc: normalize the per-exec
 invocation flags
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-4-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-4-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872731.254289.6997696289699732480.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:46 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A static entry fixes its invocation flags at registration. A 'B' entry's
> load program picks them per exec. Since load_misc_binary() branches on
> which kind of entry matched and then applies the two flag sets side by
> side every flag is handled twice and each new one has to be added to
> both arms.
> 
> Translate the 'B' flags into the entry flags they mirror and let the
> dispatch act on a single set of flags. The boolean the two arms
> communicated 'P' can be removed.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
