Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784D52ED59
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172840; cv=none; b=GVu7pR0dAhts3PCFHG5sStKFTAvs3RpuU81mZ86fPc6ZAFcHQxQS5icwgpqVm0Qr13jiuBkMHVdar6efDQEG9I0dEbQ7wOi7aDZn+ar8OzG31r0KLUo9J8ijWEPIIC6NcKS8L0tWPeGk2He/rRNUJi8lhUvrSStp2ru7qminiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172840; c=relaxed/simple;
	bh=hsEHc6PboCBsybhgnIk+yO3imfxQQUsJbE04dekMpGE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=pPh8OKYg42+iUKdihahaCP6EqzGVILF7F1Vs0dMlp3MLV0aWPVwxCCunKtWjkF5EYxeHhPFmssga8LHvQeAHgG9fdL5bPJwymZN9iwn/T2zMIskW5vhNV3jYv/ROPV5AOiUvHSPxxdyvAj0eHxSexd09emZgUINzNJq+hObe3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPGrtjCo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPGrtjCo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a706146559so208499a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792172839; x=1792777639; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4F7AU58QnM5AeXT9qv4SNQh8POIabV7G5qxZdGawoTw=;
        b=FPGrtjCo4lJ0Y+cYoMCGva7Tn6RHBYVij0XFJ4IAaoSesEbngH560zpSyilRKlxU5b
         LZ3qfCUrRUekUeoLxZjrgaRHxkkSqVgH5ECAzEks0fKbWahUnh38PHnP2JfvJB0P1G64
         sg0vXhhDV1r6MS58G0Td4ldHxB4d8NtwITstp2a0jKG//c4bcgOk1+ikiNQBrzX8QBMW
         2tqSPJ50HZhOTXkqZR8mpErkSDZfbrGpsBCXsnvs5uWCrDQW+Ph/p05/oLDyuCMgmYJq
         hZdLC8ifK18T5f/UDo9UdSPCy/nQwZVdRo+9ZH6jTUn0n3sIku0mcuau28wsk/1EPwLu
         0kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792172839; x=1792777639;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4F7AU58QnM5AeXT9qv4SNQh8POIabV7G5qxZdGawoTw=;
        b=WPKSHZ0E2P4b+5v+WFSiokuMfk8Igyl5Pl2M2HwbMDPAomfp+wAL7LCE+UilACfivB
         D95iFWPX7Qy2bzPohLiTveOEVhAAIBkY2zpL+hu9SolJUI1gcgBBQNn0v+IyJOBMYKa/
         C2Vg+qbcC/iEMyvYa5Bb93vqjlGIlGpMX4eRYyv8Ez+FINg+5Sl8gdg3xtlQbLgQxBiM
         qHIN40VlOzxKCfPCZVLRrYoPkCX3duvPyF7ESPZWSTxFgdynxnPfBkz4QOnC9yCV/Qxp
         UwsGcNDqkkw75tqLX5xWcS5OmzAaY3F11h2MuWX0jtXAK6VOGdJBKbTHGsyIfmWnGs8O
         Xklg==
X-Gm-Message-State: AFq9FYJtb1BUOagU2RrOD1PoDtAZ3jpTSPBwmFBsLLGpJcvo/a72vnXo
	TcWCSk+Eh36mXYCiQmgbj8rEz3guFJDxc6l04i2+u/MAnkPbeeRar/u0
X-Gm-Gg: AYBFou1RANOT7k7VD86TIOuqhM/YhPpQygbV3lXnOw+hpy7Hpsd6EGF2FyONK3U4Ov+
	POtWu+YyBOH9uBmuo+XZKKN4qsvG1870oFtqV83qjcyjYIJg3yjz5OUhGai0W1A0z+65RWeXeR0
	nrp/k9DfBUnQ0liSKJYdDZmITGvD9epf6wGDQhFul7qCf3Hdrlcbr6p/GPa0o7dbMMduuiz0rKm
	SyWZaBeMHWWNgnP54LKi8l5nofWOND6p3+j57x1F1f6GeaA2qUkOhhEGSMj4G0vnwzkuRAiqEqB
	ya20zRy+KdkfP6FztOCzvbqMXMdFqKz3AyW4v5h4K6USwGiAkVjdxlRbKrq7/xw8zHyfp4A37w6
	L43dQHVnCuzacLcO6l72nXsJTLUMQGl4JAxavALJeZqRLMAuHWeNpJBzd1KEU9fJTRH4U4Ne0Mi
	HeumcEODlIvX5WkldhRF9lO1ulOvjeTGeG0cWvpZ2ReD7o/6ddF75RYHWcjbRa8Kr9dxpnRhmpS
	5+BanrInk6YRsfdr5L2wpjeS0ij+pz+oOhJDZgseOTPBkiQsfW3itCBN5omR7JtN+lqqkS9aThG
	YmEz
X-Received: by 2002:a17:90b:3c04:b0:3ac:acf5:6daf with SMTP id 98e67ed59e1d1-3acef667156mr476345a91.66.1792172838872;
        Fri, 16 Oct 2026 10:47:18 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm9835712a91.13.2026.10.16.10.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 10:47:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 17:47:18 +0000
Message-Id: <DM6G8ZUKITW8.A0II2HNX8268@gmail.com>
Cc: <bpf@vger.kernel.org>, "Quentin Monnet" <qmo@kernel.org>, "Tianyi Chen"
 <hi@tychen.cc>, "KP Singh" <kpsingh@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Don't echo user-supplied map info fields
 back to userspace
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261016164153.656430-1-daniel@iogearbox.net>
References: <20261016164153.656430-1-daniel@iogearbox.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 06:41 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> @@ -5450,7 +5451,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
>  	memset(&info, 0, sizeof(info));
>  	if (copy_from_user(&info, uinfo, info_len))
>  		return -EFAULT;
> -
> +	hash = info.hash;
> +	hash_size = info.hash_size;
> +	memset(&info, 0, sizeof(info));
> +	info.hash = hash;
> +	info.hash_size = hash_size;

can we do
	memset(&info, 0, offsetof(struct bpf_map_info, hash));
here instead ?
hash and hash_size are the last two fields and the padding after them
is checked by bpf_check_uarg_tail_zero() above.
Then no need for two extra variables and the 2nd full memset.

