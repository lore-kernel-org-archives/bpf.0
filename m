Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56A31AA99
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675621; cv=none; b=jd7Oe79MhCSKweiow+fWXW7VZyME+RlKmmtwSa127KV9IbYFvzhMWRu5u52n1dxjvtMUq0wS5RtQb+Ns6Ur/YKljV2s8jXcAybqUWj+Oci5cw0otYQPSDYhOrasBB/w93URnJFzsVrACDp1Grk6tcq1gcb+gRqmLqzOB4v9nTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675621; c=relaxed/simple;
	bh=EE1wdoRj0efEsQBfOGePOzjYx/KJqvc6+IwnVfX+oAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdqiubQNcthGzKFG8iq2kIRFwFKpTcZsTtXN5e1aPQa1ST/BevQk7csOHGaC+pcK5EutaugnupHSgXjGhP5SZiUNsbcEN3Cz6lq3JW+DGPY5g+VL0EwvibaFdN9GYbzQXyiaMOTYXjiswaGXiDKKYD2RO5Js2tlsCUMdQ5FNw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAAPFPZ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAAPFPZ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732165d1eso6044090c88.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773675620; x=1774280420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Kv37lWGfOk0PsCgIE5EukMlY0TUTeBeToxWLNzU/E=;
        b=YsAAPFPZ/Fcv5QlMM8KXetnmLSrxwpSvEcqpK5zrpXpNHXS537nZGMWeIzl94ANeKA
         WD5Qrqw+eiDJeEQmXLXYVashwx7VRiILb7I4opEqLeVkeNSgYetKVEFm+ZzQttHRED/1
         rEwQ3yOxI5SxESWr/iQ5hvQdujnoS80IRG/tSw7Rev+6ZwhYDZj/dj0SzRgs901RtsT6
         TFt3o0G8ebsD8izSlCVoFfb1Qkem6ll7qAyPz4os+srA68Hp1cj30sypdLB6L7iuuqPz
         gPKeY1rkYfVUuclM7n2TtAJXDFalkF9x5hVFOKm++c/xz8tr7kbVxpCDu3aArBWQ70mZ
         K2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675620; x=1774280420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5Kv37lWGfOk0PsCgIE5EukMlY0TUTeBeToxWLNzU/E=;
        b=PrB3bsoJ1I4m6R2aMIkVjjbO5u9/O8+3T0Jiu52P/0O2lrVbaGUp9vYVzy2XK3Paqn
         q8BC1/8inF5vCihx12xnaZ5/Rt0CwGjIspgZeblSLNRdY31qcfODWZufeZGOnavY5j16
         ibUZWDT1uArj+bLZ/NqdHR230dlKCI2pXk/qbmY/nX+u4XG9ajm1fO22p4/LEFMhuByQ
         aspjBn1hjZuEEr0BK+i6oUjCu6bbcZgizoiRs55TFzY7jgq4nTxKrzG8ceZMzDOWc2ZG
         ctf8k+nZLd1jWFdRGYq+vocdFwvnE2IpYFjl83qmXQ+Qf9bqwwsFS5r4aasDKbHdQ4n2
         PJAQ==
X-Gm-Message-State: AOJu0Yw9SIIQzTFn/qeiDyLAQUXUfu8kV9WDX0o4w8xKgYQTQFEyMYiF
	lq8sJeo6LRHhwXWW2F9QhcDJwQMMuQOd5de2E257jW0LmYWQHMWHuo4=
X-Gm-Gg: ATEYQzwQ3gzry8lvtqhl+VoJxsrfaEqannLUgVRSrnaxICQlSK4/KlYtMrIKI/uR5eh
	aetWdQV2cfSylH8k1Yk4FukXl+TcJIjfLSJ/zSV6QAFg2wGToCNAvUPJEAnknza+G5SACF6oQ9P
	qLNsscPpwGHGuoeUxcslFHDEKBB9RiUA9qumnXPtk1BRzZ++61zrqkZGH3xynM3wsEN340Pn6VK
	ea0Y1JICKH4Pj737mTBW1niTCWkyJKHHv14cNG5YvFzVllGf9gtlBc9y1a4yROjeCYC4P8Y0Yny
	VDrDVc6yOHgqWqayKM9jd5ocuHp2OlCYAZ4P6eaBEd11j3dARpC0jh6usodfRpA6jlkUvwGS8g5
	yFbuz4hY8RnFl4QN6+utEcm5YXnGniL7CphtV0WTWGd1q6/oyYKi3/PX25yzVJfBelsBoDqEKm3
	Kn/Rb5FFtRSlRC/kCeaNzUPPTDUtAJo2yWPp6+QOlhfcu+hjSvuGGseIGu9gxys+Lt8s1rqinhB
	cpdwdgWPv29a9SGkDbpuYIbkAu0
X-Received: by 2002:a05:7022:688a:b0:128:d7a7:5271 with SMTP id a92af1059eb24-128f3db2aeemr5827345c88.28.1773675619619;
        Mon, 16 Mar 2026 08:40:19 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm11945471c88.11.2026.03.16.08.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:40:19 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:40:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <abgkYn1p-Q78H2W-@mini-arch>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>

On 03/16, Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: route patch via bpf-next, not net-next

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
