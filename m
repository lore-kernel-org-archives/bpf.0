Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050671;
	b=QPjwdRjnIMVXwtHEesnigFznW/hKjocm+4mXSkX9RY2bwzpWXjnOjejZfaQB38fYX2Z/
	 tg6OP/h/1M20q7IBP7/h0yWegxpysLgsGLQVyN6z0/vaF6TfdYZlQbTCA+HgDpp9xJcW4
	 2rl5dlGgi2MWLIw2sI0gB+Bq4mdm5Ie2IkMjhFjRUg8/hI9MzRkNTC64s9AKcCJzvEtVJ
	 +YtwaPsiKdnax5nwlqatrNEleTthPzPxu5RT1vu2rCdMrSHanomfC7HLBC2LrLLaFsThc
	 zWaked7ohQGyHX0PALnQlQRUTag8R2huZMM6SWBnsCMdUZHMyHql53Yx8zwRHncDN2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=pSkuji4kXwZcd1ydna+oHa+tnDhj558qTFgbXnb/qHI=;
	b=vOrl/ReCAZc9bcQZLaf6B1cmWOFlk6sQx+dmfU1aOjLRGh2bPU8u7mO0WF5MJKX0/TCP
	 KL/d/JhBHl0fQvuetxMbJFN9IXl7KHE80qUcOpbRSiTs0mPMbv9OvGrjIyVMglh0dpM8B
	 GfFkfVBsgrcGmLJm9YmdYTPzem+VEkGAxUSagvRqrWWzjNQTELyLF4cQ5Djq97BXzgJ1m
	 kPIu8F2Iqis3xGLyHFnvJ+NOYW59p0L9XS/1Gjs1m14SylOazRScpKzwUJA4tlZ9yQMwU
	 tAnxhwEvqec+dRZVI0PW1mQTlGLpkeVNMzEb8rd0+eBNhzc4RdF0oVz2o2TLL9sjHrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQxjWr92;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFC606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EFC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQxjWr92
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1072443a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795050670; x=1795655470; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSkuji4kXwZcd1ydna+oHa+tnDhj558qTFgbXnb/qHI=;
        b=AQxjWr92FxP60mndSKV1WTxMvlLowBCe4ISf1KUb5lLrWmFDGKOqW+rvkah8HZubyT
         xmx6n2ONUy5IOJNNxTrL91ftGOtwfB1sWkrm06UxgLyrLdHYWG7i/evZhXDs2j3wm0S4
         L2/kS8SMInAdFLQOYw5m219eN9iMe/ALzLEZRZ9mzRti9mbEFfMj/hrQMBFR1eoy2op/
         D5A80+nsjMEDab9wzjTy3BhVjDZbyxNs1wEgLVlN83T+ngwRY+FNpSe8bl/PdZFGHWB9
         RqCy4BfRqoZJemQ0BRqZAmRaWIvwTnzgWA24Cs1qZkIfMyvmnUeYw50P0z2oABLVlTwy
         ZvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050670; x=1795655470;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSkuji4kXwZcd1ydna+oHa+tnDhj558qTFgbXnb/qHI=;
        b=2Iy0GSG+7G4TydIFeZGHUY2yD/Ir6ogFkab5UKh7RZ0Lsbem+ZP/lknBB1JC1bddGz
         35JN8loOrVGs9HsNkf+fhA1ukXFXoLoAAMVD5wwHZX5mUwn9ujW2vtISoNKJpoivHm9b
         cbXwUSuuSNPUaKw+C+Q8VxEP1eEikelM1i+9kdPcz05Tyjrsg1vl9DvLwyAheHq8P4Pi
         FW7ZU0+W4LLuhR4b7Waczx+X3Hn3oCpvnIzySO4O3zuJNXR7wo5Gf4vABCpcZvOnVqv5
         e/1iRJ/9Pul3A/6Ukm5yyQ5ejoiGZyKEd7NldAbAnG9sg2R+Je+BQMy7F8Z4iFaMbtl9
         jTPw==
X-Forwarded-Encrypted: i=1; AL+hErE3z3Dke+ZYzjrJ/HQyA4fTAzF+WcfQOBYfL9dNfvhbI5pjiuG4PghAITcRkncGuNuajCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z3BvhpuXogYmKcEWTOREz8XNM1PEahN8Ue7I5pC38mEogA5Dn
	2bW6iDTBkwK50ltP3MnO9h88MuXG72pIoiDOsLKkdYbWEo2wm/JEFUBR
X-Gm-Gg: AZFdTZfnHEX/IUKnCAJEFJ/KOm4l7SIvM1/Anv0CV+yEEQXYoztZAsbzIFsASYYu0Bw
	BjMyeXtkdsF9QlGiJDF86qAsFmN5G/pqt2akc6acP9FvFnMl2FKPMJzTufxQ1TqxfjHw2F33RW8
	rql17KKZOQYpBK5mQc7CzOo/9Ddny9D0z1a6R250zzf9UZ+4biWgakJD1m7sImEDSr1jcsfgiiI
	YcOlu8GAgAb1rqa1csFzJ5W+AQr5+KGfOEf1ulWSiZqlOBFcUas7HkcZsc/6M7Wxke3GCI4marO
	AdICWl97ly6JRinbZnhynOVmD+9+ciO53X4oNZebEj31gYpboPfONnkjrJkVUGWqpo39TmgHtN7
	VKiHfsDxrnKz8W7R5N2slqopNnoRxclfuLBD5wnYRVlydhr+8QI3K6cPWte+nuq1lg9nbDN62Gw
	cegNrzEbs12YiLqQo1Qmtu2FeA/97OFgWVQjaWwqxjbumugq8hC8nB03bUFFVoUkqshPnhaozhE
	4suhpSry4fsuIygby0WQMtwhay8OPKFxHjKFalhRa7OcDaGnjl2XP8BuiEu4iuSovLduSFS8LgW
	kpoJKGweqRdlNzvy0DiPdKU6dW5KgoSITvXnODws101ZzV7X/rgfydVb4Frm5thMWZMZbwoWtZk
	cstoUbVBelvWBxWpo2uHtv+dEETCaeYpVaOew
X-Received: by 2002:a17:90b:4fc1:b0:3b0:9a0d:b825 with SMTP id 98e67ed59e1d1-3b3d07ab104mr4002171a91.45.1795050669692;
        Wed, 18 Nov 2026 17:11:09 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fdf456d2sm650359a91.13.2026.11.18.17.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:11:09 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:11:08 +0000
Message-Id: <DMYSCT1OYI5F.2HSYP9MZ2BRJU@gmail.com>
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <kuba@kernel.org>, <daniel@iogearbox.net>, <pabeni@redhat.com>,
 <edumazet@kernel.org>, <horms@kernel.org>, <davem@davemloft.net>,
 <shuah@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <willemb@google.com>, <petrm@nvidia.com>,
 <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: don't warn when bpftool is
 missing
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
References: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 08:53 AM Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> Based on the bpf-net-xsk-move tag so it can go to net-next and bpf-next
> through another shared branch, as Alexei asked:

Acked-by: Alexei Starovoitov <ast@kernel.org>

Thanks for the quick fix.

Jakub,
could you make another stable branch to pull?

