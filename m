Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494385;
	b=n8snq5iuc0mIp/Mc8O4hl0bwFzPeYpBggk+qZdoID5kQRoNo0CZn+2TATtZM7JwOS0Yl
	 i1mlwIN1P5jvW3WOGFIsHF+gJ4ti5kQsxlnXUbbT2/jQP5lzc4ffpu9pdM+EknpkGJbE4
	 8PVl3RaYlWojRPOvC4IWPC0WCygTmWQjG4oqKXy6IomdcTg8TKJaMoRNGk6He6f1QWfKJ
	 c62jV3FMg5/nNxNW9NZvc+W7cuzynW3iHKn5blk0LlbDj5xq/dhSYgO/CdyG89x4zlgj4
	 +qHAlpfurXRmzzKOuC4N1R+JizeYZaWkb5os0tGaeSJgx9RuUDSR8XGBWVMhk0WsCig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
	b=x1NhAk0YCQ5jXprG4moH9P1Sh07CC37vpxMleSgdjj85/wkSO7WYc3A0E4uXX40Gd+Gu
	 8yoXidgJHv0Be4woba4YnxBdBhXJ4rYkyXrjvWyecS/WzFJWuMZTqF5aMTAw+RYaBXdFu
	 swOsH6jzSzZa7H67iXjVcW+M7V+3i2ra9/T3wXm+nt+gcAPtU3TRL60SFo44/C2blIeOC
	 mKmhjcj984KuX8ZjG09OLDq2CrRxWh0V8fTc/Z4W510DgCs98DK8qBW6R0QfG8uX5F8b5
	 t684MAhvlBUP6RElxfKcbCKxALKGRRzPi+44YusytXK/ApRthcC8W1rEEcQkY8aDMQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akkfj0V2;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD318606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD318606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akkfj0V2
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20edd106so384304f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494383; x=1793099183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
        b=Akkfj0V2koYWmU75E7boNUeaTdwfWqYul4bc0/sYjzJX23iRz8gBnExic0tkxnY0u+
         NDbeDCJ4Qis47tMev4DJlCCBzYbcIodFINhekemO7qmjk6bjulsg5sGL22PDTsytVvKz
         zoINqnVCsnAxtyu+BaBOH58X0slfnvlHkG111dJKyGE6j7hHoqDwLNd6x440C1Mjwsi5
         BGNXMphWw0F6z79HepedwUQ8wpysJTNO42Me7DXSme5rvRI0Ngnq+5SCcl7eZQkrDjZr
         +fcZorzIn64uS8/eSny3cu2LhAg6my9EXJ44VxolHsBGnNXTnfixEf9jBrhvcbU3fz5T
         cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494383; x=1793099183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
        b=pIrESRsQDRBCvQ2opL4WhEHPJmlODwwE5Kc2fj5mBaJlGJk4qTtpU9U9iwc45YrR7r
         q1IqqVqmBP7LqHq7qBVMrdJisQaiKk7iAQEjUrW+f8Ev3Md/3WpK0uR2fuShftteNxoc
         cqbwwPtgh3gSP/fQzZcln9m7vDKPxhNOas5dYGVy9xDP3ZBCrbqX9HoZX8rfTV9z+ZDr
         4g2rFkc5f8ARv3E1k7Oe3MMM6dOe7otedsTU8lcg10oOU1fCpg/covDFGh2uO1WW4GEn
         N9xALebfO6s5pe4ofpd5PUb0tqepTR6+5cizIF8J/W4gREeLaK2M+i5DspDSqzxX2QC7
         fpwQ==
X-Gm-Message-State: AFq9FYJrFClKMwpHR9KXSS34IWHXVjvJ9wUdm15yBOj9rgQyY+S65At3
	VaSpk8/2RVTpuunv3JnJvL1LPVEPd8UGhI8E5R0DEZijkL2YYH/5KbMW
X-Gm-Gg: AYBFou0SEZ4P3gsZmgl++v8Cww+REU9VhpEiuuTK5Z9MQpnoLqU26G8crp73Y3Ukq5U
	TJXG1ESMRxbrxm9EHKd0bEQuoeSo1TwFTmXB70COAM7E8d1IjGVBAikC752l5X89iXgwji1+XSM
	z6ccLzl5mNdI3VrFj9SIgyUdkLFwZub7VG3OzNeByjtmh5Vrd3fz9q09dfTLhFFQV+mguRkatBP
	rc0DvpRObm4cw0Wh8tLTJFP8gzs2hv7JztPePkJ9MUHQNdpbik27rtI5/T/tNxAJU7Vi5kefQ2/
	jhNbbp7lzOZPLxe3ZcmLM1z/58j1D8dSV6hpV0GL7/2vMCP9OfN1mOIX7VpBhshIvM4uU67h0k7
	ZBkQOMKXyPtZOLaW+HckboIlmhwsFb3s95h+DmSFVb+Avko3UKrMZIZrQ8ecLgogHtFN/Pt7wwO
	NnZmYfXdE06sVZWDcNRl/Mhhf/91oc5vHUyUPziBRMU+LL9nFSk5p3/akpHDSgwXwuUJ/pXBh+Y
	QJWQ4YuccKLP+M/z8G3aS6U4inQngmt9Xqs
X-Received: by 2002:adf:e58d:0:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-48e07f9e02bmr15254994f8f.31.1792494383157;
        Tue, 20 Oct 2026 04:06:23 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8185d2sm5653937f8f.28.2026.10.20.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:06:22 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:06:20 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org,
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/8] selftests/bpf: Test allowed bpf_ksock
 operations at send LSM attach
Message-ID: <atdLLO2ubFYmTsw9@gmail.com>
References: <20261020102512.518479-3-mahe.tardy@gmail.com>
 <af7818e22b8336b796a951e86dcb6a63c8ed79e8643e264cfa8ba147e83b594d@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7818e22b8336b796a951e86dcb6a63c8ed79e8643e264cfa8ba147e83b594d@mail.kernel.org>

On Tue, Oct 20, 2026 at 10:52:15AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
> 
> TL;DR: Commit message only: it names ksock_socket_sendmsg(), which isn't a
> real function or hook and is renamed by this patch. Suggest naming the
> socket_sendmsg LSM hook and mentioning the rename.
> 
> >     selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
> >
> >     This test makes sure that bpf_ksock_acquire() and bpf_ksock_release()
> >     can be called from programs attached to ksock_socket_sendmsg().
> >
> >     Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> 
> This isn't a bug, but is ksock_socket_sendmsg() the right name to use here?
> 
> There is no kernel function or LSM hook with that name.  It was the name of
> the existing BPF program in ksock_lsm_verifier.c, and this same patch
> renames that program:
> 
> -int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
> +int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
> 
> so after the patch is applied the identifier in the changelog refers to
> nothing.  The attach point is the socket_sendmsg LSM hook
> (SEC("lsm.s/socket_sendmsg"), i.e. security_socket_sendmsg()).
> 
> Could the changelog name that hook instead, and also mention that the
> existing program is renamed?

Yeah I made that typo in another patch and spotted it before sending but
missed it here, some confusion between the security hook on sendmsg and
the ksock kfunc.

Will fix it in next version.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865

