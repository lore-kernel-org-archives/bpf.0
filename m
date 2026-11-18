Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005642;
	b=f0HISGry7FgJYriM1uc23lZ5/1vIDIL711jt3VLGWtVc38Yxyvt44+IF7smaxFp9kao7
	 c14DT0jsaQv0hu21828wztlkXz/38kZvquPnK0I+YRiGQMS4P1TILENgU35M0J8I1OIaH
	 5THrFRdf/K06DFSJsmggq6AgEOi8D3MZA4aiYFhp6ivVGohAYCwUjzwAmapviOYnd1BoG
	 gSArwVI7Fb2T8XjgwYMcdv/146Isu+V1GwEgXS4bu1XQZ1mwi7tjKWvDixJMNPZUlwJzd
	 sY8xzYKKEiGP4OcrXHgFV8o1lhx9de//omzXPQGRMrLY4uSFbmwDhpomgr5AlxX+vaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
	b=3lseFmdEKIRtsaJH/gGUq+3CuNW2FiQhJnYfOTPdUrJussgljbRvYwT7TP4NcFI2rMum
	 MsqdDewPUfMaKEUl/TMt1X2kjdyx7EgMFGhNiNg3MPnm1rlJ0/PUeNrDjIx/JzNnLsSjC
	 87pCvXJxJdDu+RX3r/yfOQu19uSCT/VLkrEhuTD6iUGBw4UcNmi3yvg/TXDYvrMSmgJ7q
	 rG38I8l8jDrsNl5EuJ2cZaENfI8yz5Xs4oLMNtPnb4mWEz0NuHT/WVgzo8yANFi2dBlPF
	 Nmit+9/xKeTzndMWAz9U9Ngx2Tcl7dglI/MaYx8dC+3JupZAGDWMtAh0p3N3d0hx2lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnqozYU3;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349B606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 12:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D349B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnqozYU3
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso8848125e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005640; x=1795610440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
        b=xnqozYU3wqgk0WhK5PmP5yOZMWat21Onnf6+sgImG68WoTaifxU4e8NLRj9klqmAN3
         sBm/1rnOXRF7LkWjDjBT3N2AZPlXNCTYbTdB8xzdjhAmImSKRcbeJrv0ezW7XN2ey4AE
         WOuXU3cDDu3EuefcniQibYvNy3Xgfz2t48Z7+LXaagQEt4XqPnmPahYvJmtwCrOcCaNs
         +iWMdVJxJSZ6XXV46hM/zUu0q2n9y0OTQ+HzKNOoo0dz+qzoDMEeP2EIWna4CJzf/wSe
         gYGPNm3CFxpt0emTgtOOjWZwvzpfIYOEsKWqkAgig0pwyHHBgqrWrDYwlHFHfFT+9tFN
         sfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005640; x=1795610440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3R41f+Uc35mAz7uI8DyanrUHiDzSxAIfTcbxQ5KsNGE=;
        b=jUP1a66pKZ4PiybWbPboXBM1DIlIXVrSv6Sv3GX1LmmQnIVhOCj5TuTFWeV4XI06tB
         fNDaxfPhuylhvcbygzxLZed2hMD9OrWlxmaYoY5tKXaLrQWgeMQH2B82yWaFhq8SmXAi
         b2r93+mo+6wEJCmZd0A+StmSAC7FaCpoEBiKmZk3mFiDjw3exXNyo8Y+fwqmKCVy403I
         IBYD1ZYYBJIzqj94wXU6azKhdCL7m/Va6UwxHf+CoyBu+REVmiKkriLcKhWFFFgLm5FZ
         qjNqIbrvq3qujff9Dw4SAUZUjMAiUrhDZA/pu/Papogm+OKhSCjHfVfqH0eref3Y6CFV
         Hgew==
X-Forwarded-Encrypted: i=1; AL+hErFG06XsxBDf367rgiN4vXi42KCvpmPXGKYTCC5i+fv5HQ/y4RODCkhz0qcA/akricXsQ2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DN/ri+/nDjzyH5A58y53bRRtAA1BBqrkSoba93ewOoV/ZPail
	qFHSdFanoCpY4lyViVAIyMAf0rR9kYjFtMa+N640n7+igt14LfZ1opCn
X-Gm-Gg: AYBFou39zEJWsrLSNfn5XRCqeVVYNrzZDw1rBh6gJSjVX45SLgPjmmQlN2zhCIBTPqw
	m/rBvUb5bGm8YSU/o6CtPDeInWnFIukx2jaoec9vLXI9q7Wv7c0lm97YYnBjO4O6JCCv//4yyKc
	YRYn9KaLNshK4e2ia7LbOwDt6P29E6B8CRdmW3arsFnjA3Akms05w6pflHtzPy10hc9zGyWMU6e
	Y4+xzC9QW4TcjvqkXeKQQwiSvr/gOAemoe81UpORTViiZNTEuGSkBTTqnkaJZws+erJhPYzgIyv
	UIuULE9fGja5kixdyqQ37jswQkVYf5grk6qe4KFwaTRUtjQZAdyZJkd1uuJWFYzTTYZmtZBrwHf
	iBA0VXJFcSOsTT4ozMKLQQaaePglj5cb6k5WUiB0gCyOkcIrEh4AZVXTfSXkuftmubNrLNOsJmY
	IIvjuWDstxERWTS27FqQJj5wu0zmrlAvVCw1pvosKDUUVOJL0mbVQrwVRVfKNNSXk5QuOX8UV3F
	L2MFrt9yZXxfrpTzHIv2iyZGNoOXDaxxpILvVn4DIv5cAydVIkawxxdu7vIgBFSS/XiSZ3Jz+nO
	uhG/MOt6w1MC+jZoNXeMiVv9CcfDW1ZUKN4iYkLGYxeMjab90TuWnOgq4O+WXjFu
X-Received: by 2002:a05:600c:8b42:b0:4bb:7033:de79 with SMTP id 5b1f17b1804b1-4bb7da4afa7mr45012725e9.35.1795005640059;
        Wed, 18 Nov 2026 04:40:40 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm202148605e9.8.2026.11.18.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:40:39 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	memxor@gmail.com,
	tasos.papagiannnis@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Date: Wed, 18 Nov 2026 14:40:16 +0200
Message-ID: <20261118124016.77086-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-spurwechsel-entwachsen-wildpark-e6322e9caf35@brauner>
References: <20261106-spurwechsel-entwachsen-wildpark-e6322e9caf35@brauner>
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

> So we need mechanisms in bpf to guard against things like that
> architecturally. Ideally it would not just be a filter like in the past.

I have been working on an approach that models dependencies between
LSM hooks and kfuncs and checks for cycles in the verifier.

In my prototype, kfuncs that need this check should be marked with
KF_CHECK_DEPS. When a program calls one of them, the verifier invokes
bpf_lsm_check_kfunc_dependency() to check whether calling it from the
attached hook could close a dependency cycle thus it may result in a
deadlock. The prototype rejects the program if it finds a cycle or if
the necessary dependency information is missing.

I have tried to model the bpf_path_getattr() dependency manually based
on your comment by using the approach that I described. But the difficult
part is to cover all relevant hooks and kfuncs. So I am looking into
whether there is a way to generate or validate some of those dependencies
automatically. I will continue working on this and try to send an RFC if
I can find a reasonable way to handle the dependencies.

This approach could benefit BPF more generally. However, based on my
analysis, it looks like bpf_path_getattr() would not be usable from
the hooks I need (assuming that it will be available for all underlying
file systems). For this reason, I will drop this series for now and look
for another way to obtain the information I need for overlayfs without
introducing such a broad API.

Thanks,
Anastasios
