Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F578BE0
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291668; cv=none; b=IAyS4iFecanZvDN4OH8deIKT1QYq518xQYtPJHpkQcDN1wLN8vny8jaxO9x1heXnSZRty3pS63lhTmlJN7OSp0GaF5cx18NYFzhdQHT0oza66DPL4raYRI2F5k5b8f/dyuUfxb7K6NzyehZ+SVRu5imaaM2P0RiP43UFEobhtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291668; c=relaxed/simple;
	bh=vod0Oteo/6Tbo55PLgkq1rrHpuWN6dhPTkJvDCvNrsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX22ys+pTj7Dj1Jw9iCnCIAS3d7GvEy68Yvg86A1laNC53xMWffGKAEXqZ0wi1PkrMKuBwr4ZlzN2XhbE6rmBsTUkRrO8H+YAjx37xbiAOTP2YuyJBzhf2nLprdQJUYNOvpGXn5dqxIZoQ2yioswWC1neF1K9lsOdzyGmXsrSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=djrMq6cT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="djrMq6cT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4649c6f040so134453366b.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710291664; x=1710896464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=djrMq6cT5gh89sVB78d38f7yZeGiv1u2vydaViH+yKsZlDYJx9x3EM923Nkmm4BWVE
         OzmNIY83Y1zKmJquGqH1WZBMiDyDGWyjaveStKuQt/9qBkUey8T7jqr6NYzeiML3CgVj
         xu8yHxpC3oFby6nFDygfBMdWKmq/NxBJdMkxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710291664; x=1710896464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=t6rFbqhWK9Ym8TetxwUuuiHDRB68NBA+xuWjPccYhozPxm8syULMg/SJX3uqcgHgch
         I+uAgOgPbI+e/5dAvRXCz09lAwlcnYjXAWBX6BLyPquuM6Ndz2Cu7jlt6ak3bEZE1H3b
         Y5UMQclDyjezm/hNAJocA5V/nSdWdqObJYwgvU7FOCJRZoGSBbWE2DiI+0lZ1J9jrHEZ
         KTZV+NZWI24f7gVI/rCp+w4vvThRAtLlCq+SVFHf1OrLfLt4Tc6SjCCiVld5QmnIo09w
         BUhnUbaVGyK4Q6t56dqP3ZpeoHfSp6aNOMBJzzA+MJqO+tu0HdkZ8I6kFGRgewK39Vz/
         7sjA==
X-Forwarded-Encrypted: i=1; AJvYcCU3CCLO92U6Lvi3czX6ne0k1U8JN5avMR6QaH0SuEBl3vg48avnLF/NSciOojWNjh60JEoI7jsgL9RJOaHmc76IVBQo
X-Gm-Message-State: AOJu0YxFSnrH2Ze+TuQSBcSo9aLsRsnABuyi1pGlIYTC+JLUhyg/mrU+
	/t3tlvSPort5dPrnRfQEGa32JvCB7JtrLUbfiuKKrsuT4mKOqpAOdwWASjgMIwLTJLcq0KmouG7
	WQQYKYA==
X-Google-Smtp-Source: AGHT+IHFA5821GNE/ed6DM3anSa8jRT/gi7PNRl1OwIXNM3koUJOwF69Qf4m9biS29rLeUdI1wBvYQ==
X-Received: by 2002:a17:907:168c:b0:a46:2643:8463 with SMTP id cx12-20020a170907168c00b00a4626438463mr5728118ejd.74.1710291664485;
        Tue, 12 Mar 2024 18:01:04 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090628db00b00a465b6c9a67sm88987ejd.6.2024.03.12.18.01.03
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 18:01:04 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so7338411a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXx/IjVd5o825LQo2GPVRHf7RnW20DRhsBMDgiNi5t/c3GD4LA4GG6WUOUPU6A2okuni4hpjsrxnqnK/VdIJwag7TLn
X-Received: by 2002:a17:907:c247:b0:a45:5328:8432 with SMTP id
 tj7-20020a170907c24700b00a4553288432mr9215023ejc.50.1710291663582; Tue, 12
 Mar 2024 18:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 18:00:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  - Large effort by Eric to lower rtnl_lock pressure and remove locks:

W00t!

Pulled. The rtnl lock is probably my least favorite kernel lock. It's
been one of the few global locks we have left (at least that matters).

There are others (I'm not claiming tasklist_lock is great), but
rtnl_lock has certainly been "up there" with the worst of them.

            Linus
