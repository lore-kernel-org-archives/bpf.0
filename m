Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC24266A5
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931587; cv=none; b=i7zPsnligVb50rSSKmcWtlsBnvCaqaI8nzAj+a5TxlDNZWRXxgtwkv+KqpVTFhj1fdDP8deoq1CUC36Ffr+rz+4X6CQ7icVp+UNQGIzVGJR/lBOjEnfPUf1ZoHoXA5XP/51WTwd0QqCpm3CcfHUUqYfaMuhaEkIX1UQVSvRSmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931587; c=relaxed/simple;
	bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUv1t7F0rvZm4WpaOcL5yY45QHO6cuWyWhPiTcpb8Ngh67KohbpgJQkv3t2NUxhijyGqiOu/GZcapJfRQXprukIuqJgKaDwMRTsXOmPu7feO8zcn58J4KKDY2Cyo51OezluIy3ZuqWcuGFcL01qy30ZsfCGaUTwPRk2V7rm/xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a988cYxl; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a988cYxl"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ad70765db9so6384633eec.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931583; x=1769536383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
        b=a988cYxl1+Om4HJ/GWt0JJHZxmwnpLhwDCm046jmnwAfKiL7Ah8N42F03Lwd6L9wHV
         jpvr+CZfA8SjcCwF/a4FOXNlN1pDQ5PIfdbAOAbo9AqO7MmOzmtuGW+nsbHSFJuCJfut
         RsoxEbQKsb/LRbx8AXf/T0TJPksYDM408EsUmZ6vp7c3TFoat4s80yQ5heokSuBqRK/t
         ioZzQ2zUFckQpaCc/mu0fDNsSxtFquL7mOTuxOOSYiHYTeIEf6UvdZ6TM2GQw+qnU9ta
         qYa79xrNvLraq35uChZesI82N0Ejt/7PVVOOMsO9IBy1rl8tuSfWeZKcb1uSASexabG6
         6suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931583; x=1769536383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl0W3qdMZBM1vv0gehcElnAQGY7Ctp7Sz0mFRO9mfIk=;
        b=BpvwsrH5SaM/BOYXeEMx/XTd0ZJjs4ff2VSAya9JSzvvyiEuS1CpggP3e1cdy26OV/
         QmV3Lq37AV3kw81u9LtRZ0EkmwugepX7Hx0JWuzkSikbdmSNETZbjYCqiYdW65v8vJHT
         T0X/oAxGvGilHanNDIph9/gRkrkQONUm8EDgOmTJbs8jKpKchDfS8J9ys7lvQwfFedJf
         Ocb5zhPo+9+yCy6T7CgiBMf9In1YFFP/eNVmXw1T86J1UFe3NCRry6dy/tqGoH4+0tsP
         XYHQAoGkOr/up8Bm6Fegq2KwHsyaNvdYBqCNkYwQpOOgPtWxGgbmtjNvnkbKa3jfbC20
         I5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVafWFSzeyS/dTv94VJA1ALvCHLxDjYJy7hhl5wITZU07Pv3DLHa3WqWBXgMPIiJBXoN90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymzdrmTOCQHPDPNGbYadbBGcO7NftkI0gakrwMaR/mXsQV0tZ
	YQ3XmZ77sTujU/pclbj/f8OZ4BPVvGTYjppHGOuScu8fzlKjhvu4sS4d
X-Gm-Gg: AZuq6aJWWfxxQkVnwqDyanLNB36NWQj1BaMOywc5boFKt/JU5I50st+G6gTzU4g8dPK
	2y5T/dQ5lLN2fL+61GMvWOG8luUc1cE7LsODnBaMEeSBTRijudKNN8/vk/HgmDNKfxoMRUD3jjU
	ceTCBXecOhj4EEt6M/ikceFS29OUUr0S53kCNmTxERDmSjW6gt8puRCuRH5GjT8+Js7qjItCQFR
	kD5BRlc+xmBwfaRFF0T5B/SBDVkajcxnD6ocCrp2WDtcL6PvZYhOxR0tPZRWu2UiyLsTEaWWihB
	77KalU8KzYKRCV0GLDU+NWxKf4FrsGHaxpvuqkO9ujamqnYvDjn48NB2O5TmFvFoS7K6WjTo2Hn
	9vT7uerJYO947+g2EtChz24ZkMke0LdJ8UhunLAxkRu9GOIHX6HEQ4rtOTbbTyrrjHJrR7l0525
	HLpO/wUJZrjnUMiHlXeFxfpCyQytI00xwbhxoXjrNYeKKutee9SPj/vzef8XkMuD+TBfiE
X-Received: by 2002:a05:7300:f10c:b0:2b0:5435:2e04 with SMTP id 5a478bee46e88-2b6b4e8f9d7mr12409696eec.19.1768931583432;
        Tue, 20 Jan 2026 09:53:03 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b365564csm18083233eec.27.2026.01.20.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:53:03 -0800 (PST)
Message-ID: <a59fbe952a4e4072eca8e3c6eed6d960307f4b4d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, 	dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 09:52:59 -0800
In-Reply-To: <20260120070555.233486-3-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
	 <20260120070555.233486-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 15:05 +0800, Menglong Dong wrote:
> Add the testcase for the jited inline of bpf_get_current_task().
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
