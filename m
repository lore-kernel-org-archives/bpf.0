Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9E339A9
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 15:55:47 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9475691
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 08:55:46 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65646efd262so12617276d6.0
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138945; x=1695743745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifgYcZvjKw2cBT9REFnp7LIYAOxPSdO7nFqgFyE8WEs=;
        b=PzxB2edaO+egAaeAquVFBGk1U0gPZBrzyD/Lb4DQzd+iACwt4VhxhuvbDEpVvxPPf7
         oiEh8exBBX28aQj8eHokHUBQPM12s+RH63HxqCVKq/gZqJ0aHYCGtL8MyEH9LF3TtEeB
         yh5uE9N6vaileGGmpMUpTtJgLU2Xo9mC/bGuoLrrsQ/pEhURORvqccE6GJx8DFFQu5tQ
         MEGqUh4SEdG4WpMM4MwXrNBlRnWlGRN283wfZeTptDaFqMJ8LlisMOpKP08drUioyCQG
         ds4BMxE6GbveNBub8MG2lfqTSBOS0/TRhTJr5iGv98hTTFSM1GXjHJdFCaqQ/TbaNgcI
         VPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138945; x=1695743745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifgYcZvjKw2cBT9REFnp7LIYAOxPSdO7nFqgFyE8WEs=;
        b=NoC8iE8L4J9cXup1S5KBge6xyYxpIf5I6TNHWPI5qGGElHcyxP/5E8ijxBD9ioPMhF
         SgS7XAU2YskgzG4LabYjTCin8qnW3wX8R24OFDQoh+f2oRfpsETkA+9/rpPaGp/4qy+m
         MkFk7yB+fZHbgdF+JEBv30oF1KNnGRPTG8ayHzV3fBJMewwl945HRY7Fl8Vu1JKoALZt
         8UNStPBuKxIV5Xyun+0VcKPrTAHuD3D+sE18632hSDrukEmCTXariRvS7UOf+YBHRJlR
         6DLCCC/d+xvrmajAsM8f27SSHW+js0qrEK8XD5n/ne9ZwVBPCU/3PnDb5atokigsmCRc
         O9tw==
X-Gm-Message-State: AOJu0Yy4t6Z55pVwbtQs0LTVLWQ4xLFXxVudi2WgxP1ouJ3hWzt/o1uT
	rXOFiGFv1EKspE2j/uzWHK6zXA==
X-Google-Smtp-Source: AGHT+IH9FEniOzsWca+/1Wf+ppFASZjsWhBOtYuWPkYD391WO00EEY3aPxVC1QkuB7jhO3QwnX6U4w==
X-Received: by 2002:a0c:ac01:0:b0:656:1958:aba0 with SMTP id l1-20020a0cac01000000b006561958aba0mr9647639qvb.13.1695138945592;
        Tue, 19 Sep 2023 08:55:45 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id i13-20020a0cf38d000000b0064f5d70d072sm1773772qvk.37.2023.09.19.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 08:55:45 -0700 (PDT)
Message-ID: <22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>
Date: Tue, 19 Sep 2023 11:55:42 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF memory model
Content-Language: en-US
To: paulmck@kernel.org
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
 davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
 David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
 Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org, ast@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
 <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 05:52, Paul E. McKenney wrote:
> Just to make sure that I understand, the idea is to compile from (say) 
> __atomic_load_n() to BPF instructions, correct? Or is this compiling all 
> the way to the target x86/ARMv8/whatever machine instructions?

correct; i'm compiling with clang -target bpf to BPF instructions, which 
should be spitting out the appropriate BPF atomic ops.  then i hope that 
if i get the compiler to emit the reads and writes in the correct order, 
that the JIT maintains that order when it turns them into x86/whatever.

thanks,

barret


