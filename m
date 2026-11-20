Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207371;
	b=YoA2jTutEEukSwr7vyHhmB0oz1alYYQHQDHi6Eq0bnJaCyur5GAu2gdInf/tMwc3147K
	 T1aiAOsFrGxxnc9JIhSJQW7q4OJZcc1p5Tu7dhzvge2hde3DWevnfL4qsAfvblXH04+w4
	 93iMkO7xwBs9yN8U40UzJNHrwXFSYuW5k1DtW2yoMd2I1ghZezWfHkz6J+LTd6xUnm9x1
	 lx5PpNCWfi83/256OuiDSw5lc51tv76apNbBMIucVaOsR4lbIUSXXw90KGB6/8X5wbvTK
	 NPMcr9UFGpV6/pUDJdf+AVDl1NTeTkHSk8kZkYhzobB9k0gsU1htaq9RQMo4iQyAfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207371;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=5Vy+uDDmlpqXaPhIJuzEyGUW5XXKRnuQUYCNM07djE4=;
	b=GK7f81L8avtlSshs2+A97wQV4Mq+WLdCx7fk/hG3H+Z9zjAHITv0zIAXJjEz6/QDCkJV
	 KbMdQmxbBPgt31B7piemhLz5SgVkANCAzt8BTUc+TKP8Ol9n6rgtN3tojQ7W0SdpsORNQ
	 fcZwKQvn9tNLSGs5pJAk1VWGlm/PXIJf2xlEwfewAACZRFRCn0a6pmuINjCnTKrwpIhXX
	 ZfQIfccyQlhfcbraQUfa/Pik1lMdF5uBO7SijoyK8re/gxRJ6btn4DJehrTGNAr/gdMSQ
	 BkdxKufOHHVDn7k+pnb11Xz7z90JC7laC1bpfLNwr20QiaHuUDG+fWgHp5EkIgc48Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E3606C0CF
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9E3606C0CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55d3563e50eso8191751cf.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207369; x=1795812169;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Vy+uDDmlpqXaPhIJuzEyGUW5XXKRnuQUYCNM07djE4=;
        b=xmIu5w9CECEeWJhVlQteHb95Mo7IyJLS/rtxJXvfpFZXoExMvumTqxg3ZfyZ0Vf8z4
         cmm5yBVbDaguPOF3PKlwlZ8/WdO5ZahFW7uBD1+Be86FD7GjFskwaIXiCMXq4l/3Bt0b
         F+dY0BOZc5V3ZFMU2cHeCti5Il+aO3Pum0pJfgaI4p3Ap5zV4/mzbQJUI1TuuHikCOD+
         7wf1uwr/zo42ap97XRI4tMhfVkI2fLo2RVmIn2iwHs5lK8owmpEpKMrkAWrBoOMxAw2y
         D8wC1X9csXsaCMAANNfjeHzmbLfATg5aUS+Mb8YBFzHzAobs9H7X/5TtnPVXNuznMsiJ
         K30A==
X-Forwarded-Encrypted: i=1; AL+hErGUcw+lrQUtyT2LcWVyL/yPTOxsrQFVe79YQ0OnEXtHuqk1YS68jWD6c6+L4ReX61D+yfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pxb/vx7lHsi0qcy2LkGc64tqWmanhVN+Ek10pROFgy/dAK5gL
	rFED1LJvwEbrNQYxNKN+37sB6ddW643jjrKIojPpXTw3E4gONIHL/Y66
X-Gm-Gg: AYBFou3WQG4Mw80sLGlVCjm4VMymTIMuonA7h7FCb9CB18rywkgQucNq/0JWo2QZX5I
	sPgjUhVHJ3EeI64UBDwgmr+BLJTEb8laikUQ52NJ89bFP9ZKUc2YUQe+6Pv/iFia//m1xTONaXS
	2ugyeDex8ZCXtQo7379Ki+Jhq/ImUiL21F90ompgxZvuUiHrWln+uNxWqhQ1v9xRIAucS8wRCWY
	aewjrikp04MF8xZkzdvrFTNktczTBA7u3/yjwC8NbMClSyzf2nlK8ofEeomaAw/9lX0gxCRUFhZ
	DKaCgJqQS0JFVsfedCWn67fbURXZLkYwzh1uBDABCArc7RzrzNLYH9b2c5VkxCDUoNN43Vv6u75
	7gTab5PB+c5DvcLuKxW8Q17Vq5tMDO05Xn6o/4YSKsYe7wBhgiOm3vvot25MAznowoXLJzifrqe
	XpNZ+xSiF0F66GjrLn498vPzDgEot9w84A3jSC4tzrZLXZgeRkBLZlGWkkM7nQTMb4kOMcdBwML
	u/qYySm/kq9ffs3QcF7N8hzT+mp3HuO08rsvO7R6BT0DY8WxYZYi8Z7/Mfva+GWUbP6eVJnUGdO
	zMroDUmshN6oiE+KZilQv1YLLB/nEKazsx+r1z4bZbpLBrnyaeikoidR9JKmihAlH6VAKYu/P2I
	W4iL7HCV/NTevioU7NGzxTMYLUY+v4uN2nllyquL01RMfwLxLwrFz
X-Received: by 2002:a05:622a:647:b0:535:92a6:22db with SMTP id d75a77b69052e-55d76932dc3mr81030961cf.1.1795207369141;
        Fri, 20 Nov 2026 12:42:49 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bfe82dsm34020236d6.0.2026.11.20.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:48 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 1/8] libbpf: ringbuf: Honor zero consume bounds
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711452.18576.3585895078868133287@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <9323b0acc22de75ead4732db464672443eb141ff.camel@gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-1-33fde039ddf3@kernel.org> <9323b0acc22de75ead4732db464672443eb141ff.camel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Could you please pack the tests as a separate commit (or commits)
> at the end of the series?

Done in v3.
