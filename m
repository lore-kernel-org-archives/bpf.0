Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142305;
	b=GOes9lFJ3NLWXHPLNL2ypIDqdv6dA4mhXzEsCAqW8QqWLWU3omzKUTvvM3zJpl/kOFD5
	 hCOCxSX1rpMR8XcVoMpHTo9JlqD3z9yyNH3EWYymKILHgocIIzpDHdBdSvX0GLDuKb6tk
	 5iEgd1Gj3ZuomLn318Gsmhr3nXoGM4jPhRE6dvn1HewywbiTByqJX/tIxE1y/i6engGgs
	 mHl1/sO+FQd/cVQ0diPKziGuCPxTrPTHcn4NH/XbSgZU8hFNQ1L3sj1BZTKBAsjirqkCu
	 Pwbn3iz2em4nahNiGPjfjCmAESgogVTD9uHSyddnOD68XolAA2Uw3bS5soG03EA0SOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6fm/7Od37W9xirEs2egJ4RAhcNU6R+nwZwm1aOR6Xgg=;
	b=H6HQIz9pLXf9lEATRuojHjBUvJhiFmw527cLpZefVJcb0sD7ygOQobc+OMGg//FYnpwL
	 RgMZZ+fMPMtoTRNM90LqdTOuRyEu1lAfCxmBWQ3YcfdSGkmLEFyfdf0aGTUeu4k6uVCYJ
	 la6q6zo0zU3/UGD+O12W4+cpTBqz5FzUAOdxoKd31MF8kMVciNXA+O4kNFe8N7NPGiFHq
	 +zwIm6H/ZO7N0ZV3clkHsPtswRtvcQ3DRwaMJSznIJSLMSq9NHVcJkuTW2HmXLGrk/OMC
	 HMx3MZ/OSfiRpn4tv82bj+xsM/bXUA9ZFkKxfU1IcJwRrpzl5s5VOWItHli+xgnJKoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4xOcPei;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0078B606A320
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 12:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0078B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4xOcPei
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b2513decc3so76478c88.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142304; x=1794747104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6fm/7Od37W9xirEs2egJ4RAhcNU6R+nwZwm1aOR6Xgg=;
        b=k4xOcPeigRSTpZRV44ixxFgP2zhVuGIOET5EjBZTlK41W8M25lLEsQsNd43ZAaaIVP
         FX/iY0oKgzNagZ9BCA1BCOYxzHa0nHoVZtfPmpsPPldwxA4N1Sn3O7/f7APg3dz4ImOE
         OVyXKXxDGsrJzmLrJiB0TVx8koYt5onveEHP33W8vfypyvgQAbcLd5QjuraAOKS8Xs9t
         tOK8k8C2YB5qPhUw8GyyfOOgnfHI3amkj/fDJH6QyhCKqzPSjfoLuz13LKqURVztpeHy
         FsR2CYsjuaitZhuHCv6iFTN5fsvQcRrGKjlj+xJwkSxvfPUk2TU07kFae5nG+h1biplz
         U6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142304; x=1794747104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6fm/7Od37W9xirEs2egJ4RAhcNU6R+nwZwm1aOR6Xgg=;
        b=xJt+v93umToOZOlrq5A/Twj/fcTmvJ2OYOk7bHWIqd728Z5WDc+i+tGkg79ER+R3tq
         ddAIAbgEL//ajTFpWN7A0U87Bb5gdSJyMn6TSdSbNv/S0+IzQXNO7anKjqIOEC75w+GY
         euOpJylxlbzwc099tSCacQx75o/Yfic8bD8JF/QIdEIQC6/LKfWjBDzMb+Ck/zk0uGWB
         fNjsEt8f5/X163PICYht8aX7HHMHBY+4sQaCtUeiE+BxHdlKdWdux/2gSTFf/JTt9Ii2
         PYwsntrtGnSoLOqzXt391hp+H67x7d6HckuxmfOlfadEaLqVC/PvuWT5ojKzxu4l6nVD
         pPcA==
X-Gm-Message-State: APuU4Z8dJxVT2nD0rHhbXXv2QKW5W0hbKNVGmnkM/3pQ9BZzeC9Cb7fJ
	ALhhY7swpL5gd3mbMLzNr1x/RA2CU+Sq/8gRcT77+YCndvH8+0xd5Udmtco/7vLv
X-Gm-Gg: AYBFou2Ih08XC4T6wy70gUduJQEcElZ1zquGNH8099i07f2kecocsK9myLf/XU6OB4j
	JiVK+SyDZsw4xIzMhoXrcxRg67pAhA2Ff0OLAWUkPQrZ5ib6+1jxrjgPyiGBVQuQaLPQy3iZMqt
	jNf+8peHQBeMWyM3zHB+T84YKrmvuFo2zgqQMDP88QV/X6zNGbqytFvmNSUEel8JE86YvWNk1Ne
	V+RPSDclB9O/iziV8yzOvZgEL0OKJRj0vhFsHdg9vvRM93a1kHzqA5yX7Qu71/gHneg5fdjbntw
	jw3JvvsycsHSaAURETOUGZlXsV5ouvFPZtCX26HuMqdhc3KCG2KpFLTO6rGrvmpUa6QlhODP1bw
	UEzKneyjWsxmQOd/KDoQ538iWLtL3RTM049yr43nkAGsr1Gz4WpDT9sVYJ6Ib7JTSSP7axbz43F
	x87JG3vF99S099ZosKSjFAfIvBWD+koVS4/N+ak8f9jVBqgSIsbsGgIJNusxtMIjZEHQaylYe0v
	mIxXKcR3Ez3KW0mQnIr6TYNIxxw1NQ4XUbVMcnAm/ZBWLHezba2LtleFwk390E4PEASbixvQQ5z
	RAYyeOwkrGbzsfK5Lkc8a2B5ZrkV
X-Received: by 2002:a05:7022:b0cd:b0:1ac:d029:70b5 with SMTP id a92af1059eb24-1b39ff08a4emr2126544c88.33.1794142303911;
        Sun, 08 Nov 2026 04:51:43 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:e4f2:e374:aacb:8251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771ea85bsm5927162c88.18.2026.11.08.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:51:43 -0800 (PST)
From: mdshahid03@gmail.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [BPF] Question about error handling in btf_populate_kfunc_set()
Date: Sun,  8 Nov 2026 18:21:00 +0530
Message-ID: <20261108125100.117391-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While reviewing the Smatch warning in btf_populate_kfunc_set() in kernel/bpf/btf.c, I noticed that several error paths call btf_free_kfunc_set_tab(btf) through the common end label.

This function frees the entire kfunc set table, including sets that may have been successfully registered by earlier calls.

For example, if krealloc() fails while adding a new set, the original allocation remains valid, but the error path subsequently frees the complete table.

I also noticed that kfunc sets are registered from multiple initialization functions, including a separate init_subsystem() registration in net/core/filter.c.

Is it intentional that a failure during a subsequent kfunc registration destroys all previously registered kfunc sets for the same BTF object, or should the error handling preserve the existing registrations and roll back only the current registration?

I haven't established a reproducible failure, so I would appreciate your clarification on the intended behavior.

Thanks,
Shahid.
