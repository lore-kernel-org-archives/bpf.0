Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275E47D93E
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073889; cv=none; b=MvxD5k+bPDHa+rTplo++RtfQME9+o3MdX+2Prjv+FfkbpnTSNIEr+Fl3Y4uzOUDtszhBYhC6DlBh5CKNfg09O3Xeee5m5vUqWNDeTlmWP2poo9RZ2z66de6G85xVwiLFaGYwhdBxrJUK+tBp4jNP+zBGDnVm0CDIBGTcmzn4RY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073889; c=relaxed/simple;
	bh=KoMv95V63+sQ6hHC2/qVIggDOpDkFVCYgeGxf/aedgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA31DDSsI9nA5JDo29JPG9ckMAGMBWJhKn9vswuCeNqYQgNLbO3qqQD6n1Ms9Zemp46OGCOHfv2DTpGi8IGxNFWf6b/YKkRgn46+Vwd+o/DI6G7/KckJC1XgzEfhKaPZrXC+7k5dp/fXV1lrbI9YarguS5+N0GdzS+vNNQ0UNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKCnfIgQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKCnfIgQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed2a06b9eso1840847b3.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787073887; x=1787678687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bS0udjtsLIre9TBO02jitQ0ARuyv59ZbyY0qyeZCnZc=;
        b=XKCnfIgQZm3RUNuq7sTtJhwinG2yZsuaHkOd24EhMNz7xESmu9ZxnPV0cVrC9YHdlj
         ckVacvyxuWuxQZ7i0q8GD5vM6wp1KtmgBqbXxiiR5XLs0vct/92cMhW2Dgg4gMAoJ4k4
         qDTnOAy30jjTmr+jm3dRs3zlznaf3lPrZlsRhlZtUJaPiVO7MTKK3k1mJrZLvp+fB41E
         OWb1t6cjY0ZRolQlYBBm0iq5IGgPSwgXmR3mg0p919qRIZd+a7rOa4maINti7Gb7JkK2
         mgrLC+fc7EynlsYDchdYgWJe1rSwfQNEcd8+6ByLK9dpspjs/H+Vr2OyRobSulHaZKMv
         MK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787073887; x=1787678687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS0udjtsLIre9TBO02jitQ0ARuyv59ZbyY0qyeZCnZc=;
        b=MvAwX1c3HznSi1aY4IODUzjqjcnCk2XGftYGXuugwKevDWdnDPojgIeNQj/+spcdbB
         bXrAk4BCCWj9YoiwZY8XnL1bhzStt3tGSAwXT/tBfzq2DUgUBZkHw9tJ/GyjORp+GgMU
         eqig+J3l3QnXFywINbGxlz69dhY1cu+UMfRgSEv+XnuS5HS2eMBxihv6Z85Bk9ZW7aOu
         zIaUSQyKTlDjGsO4RW/i3FKNuqz3vcfr1DXAaSUjP3tTOce06604GP3KFmhi/hN5v7sM
         /tcOHknylYOcb/w5w79LrolOeDEunaGKOkfJW/4aoFLqhrsr4DeEnih5C/QyA3C2EvoP
         LOiA==
X-Forwarded-Encrypted: i=1; AHgh+RoOhHhsOxec6Jzvk8CCkI2krAYZpjoWgc+c4MBNSOddl++fJgukOxQGb6N8ntmmdjqg8I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KvlodPOJrbKsZzbP5xMRJQG8CzbfQvUCIl5JPHWg7JqFb2c5
	pKd98KeYFIArpMe8RjrUPSZINxuAE8kuKPF6FuwhG661halDvLYWu/Hory8vIqbc
X-Gm-Gg: AR+sD11dsTHew4Yuu7gKRi4afCheFyHfGziTGxgeKiL224JuETWox1P3lkTeCB2KJlV
	hf+oDAc5IkhG1MdN0OZ/faFrAfc1b46nAgQBut/7nd/S5EuJYYat+7yaJn93MQ1GEqsUAZ4Ceig
	E5qtNSUk+yZuDEUHO2yklPieYvIDxuXpKwC8/Pn1+4L6Zmmja4ev9p8xgB4y3oCj/j/sX2LRq4F
	2DYEAoGBhlwmt/G+v0xrEKxFD32auJQUOVYDwsPdr/YN4UHobHT5Pu8J5h7YK2+nwnX0GnzpeB0
	uovcXmNw95fxZXVs9qDID0Q3rs9q4xIYmrE5sZiYIosGPAEt7MUHowk1JWjrlxZIhI+IMhFQjwG
	v6N67AkeoZ6CsFlkQF8vdqFc7UwLasJrSDedO/r/UPDRc/LPBVzVqRARyilqZ/OGITYDvzMpOjg
	kxyzvvfL5/2+Vc0FabxxPVWRVxkh9ALCM9Syr9wUGbwMxwpBv/0B6ulzvk3ZCMZXa5zgFlO969M
	Fy2tbKOWv2zzAJ0ZUNXIVw=
X-Received: by 2002:a05:690c:e155:b0:826:5659:28aa with SMTP id 00721157ae682-8371337ca5cmr92410727b3.32.1787073886758;
        Tue, 18 Aug 2026 10:24:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f3e5:832a:1675:b570])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068c24d45sm24956597b3.16.2026.08.18.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 10:24:46 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:24:45 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
Message-ID: <aoSPxGzZAiNCPPHd@zenbox>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>

On Tue, Aug 18, 2026 at 11:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 15, 2026 at 1:20 PM CEST, Justin Suess wrote:
> 
> If you care about knowing the state of lockdown LSM, doing
> bpf_probe_read_kernel() etc. should allow reading that state from the program.
> If you have a BPF LSM supplying a dynamic verdict in your environment, I don't
> see why you cannot use the decision procedure from the same implementation in
> other places of the LSM. I doubt you have the scenario where BPF LSM is shipped
> by someone else and your program needs access to its decisions instead.
> 
(I've found a workaround with tracepoints that removes the need for this
series. Thank you anyway)
> Lastly, given the difficulties we've faced from the LSM maintainers, I'm not
> inclined to waste more time in explaining again why this cannot go under
> security/.
>
Without wanting to rehash this issue,

Both LSM and BPF maintainers, some cc'd in the thread, have worked with me as a
new contributor through my mistakes and volunteered their time, expertise, and effort.
I cannot appreciate it enough.

Clearly, great talent and commitment to making the kernel better lives on both sides of the fence.
There's also no question the whole kernel would benefit from better communication between these
awesome subsystems.

I don't mean to admonish anyone or assign fault. Debates happen, things get heated,
it's what happens. But the fact that multiple series are stalled on this because BPF/LSM
don't trust each other enough to have shared code ownership implies the current process
is broken. This isn't the first instance of this breakdown either. It hurts new
contributors caught in the crossfire, maintainers who have to tiptoe around this drama, and 
kernel users.

If anyone is willing: I'd like to set the debates aside and discuss in good faith how we can
establish a better process for LSM/BPF review, testing, and integration. So we can steer this
conversation to the technical side, which is where actual work happens.

That could be an LSM/BPF integration branch, or Documentation/, or something else, or
meeting up at a conference and having some beers together.

Kind Regards,
Justin

> pw-bot: cr
> 
> > [...]
