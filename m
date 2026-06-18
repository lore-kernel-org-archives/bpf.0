Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3F3242D8
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814116; cv=none; b=RUaSVAp/rxKy51ac/9WDvvdG1Dg4S+t2gjwt03xCghzE3wQ+SZ4YJXJKX9t7bOJnPqxf7mXb6Qw1vPfJt3uRCxP+NPQ9VvIbkmqomjqzAnMlCqrUhVadiVRGKMHzL04hJBgEOvD1GNF1D7atNPmRIOT2PiB+y20+kqM+BjkdNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814116; c=relaxed/simple;
	bh=K7BlOS5ZnanYlo8YfioNtwoyHjaE57dvfpKSFjgnrfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sO/d+4kdLv1z+iBrze0Zb6THkrVGCDLVbDIVN7qFbrI5WK5rg/hoXRYUjaWtmtpfvZaucLGe0SIvWfWjtBGN4dsuHrIFzYNnZ+JlBIUtBvmnqCmwKHE6Cv+JPtsOF418Wuy9Y1mSDcrt9L5ta4w86jldVjRxEH5Qq060xZuZVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1GbH6ta; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1GbH6ta"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso757246a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814114; x=1782418914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqVnbRm8KqtJEACQ1WwFbfGkve6FBhURy9dsfQ5YnRM=;
        b=A1GbH6taT1f/9LIuRCWVc8MeN89lOsyGrgJpHcxxK/xCkimISlGIGiHuwGcRgcrFxW
         bupUxtVAFpHW0diU9En1ChUs1Nkx3zXM7z/wuLrpE6QXdrwC1U/z/qDQlAnwaXEI4aSb
         /BtQachWt7JiSjs3F1OFv2zOu6FM8IDrbUX7hRkj/DKoG/xSpe/bwJqgHlY3OKuvyJmX
         mKkjgPfZlQ9iFXpMt1FdIVh+FnSaIC/mL1Ai1hLfIaz63apCvbQx5WO7lJj3kyNLu4wc
         84DmdSsdWCktJExA7xNrdZBdLMG0SYiJEyjkn4+Sv6d4QrQ/ywq8gHcx2CMLnpiAu6Er
         RdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814114; x=1782418914;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqVnbRm8KqtJEACQ1WwFbfGkve6FBhURy9dsfQ5YnRM=;
        b=Gc8jmc4RKw3HtVxZhiH7Lzeq8BjepPBe7ZV7qQmglLsXmNOwjV0ne08be6vL8cuL+P
         6H7+rdqZTgvZlTiYUxYE6YR9Ei4Lu6/D76Ai+pGakSZLAE2w0wkOrbPGdSyYbgatSyFb
         DSkxvXZxWFKvfIXqPk5tgQ5iwEsbb7ylOm8N9WlUdDxxOKbpvr0gaX5QsUgNhCVo41T1
         IaoV1nLnoAkt3ySmn962wg2SWPhuQh8VeY54QBeB4kQl3qR7MFHpOnj18+a2hn5UKEOL
         1dubrsAtfoiZyTedLtpgNI6kP86Xsxjm+oUmHPF4yKs/aIFW3tMMNpH5ZWFtQvm0qbhr
         o1fg==
X-Gm-Message-State: AOJu0YweH1ghORSX0hNnCDSEN1FJseACXPiX4hg4TZh9SSBhnCU2vcmn
	Fwc3jO9CJ9m0wnotu4+liieixlAXr+iq6EWfdMmut7LxBUTIIdKsrUJ38SEmyFdL
X-Gm-Gg: AfdE7cn8O7yTthgU20r1MQBr1FmWj1M3r7CBMFnKUtcywu2FSSR04BNzniQl6Kp6yZD
	t2BWlZ9A9tO8xP7hdjejG2lNgnqqhsHvzqexQtRFOlQzVN90Mzw5NXupk6i3A3TuWeRMkewNZOv
	CuPJusZNZhucRY2D6rL1NyYiMzzrIvZyJlsc5nz5WgddjLlg5dgdzv0AfUMDrWyl17k3WrYXF67
	sj5iGi4BpBfoRHKLYNoJzmGc9We919JZyQjJM4ESWZQxPEtiaXPdxR3clgwNGg9Dixs2YKzIjuR
	ekqffemcBYiWmSvGASN3XY1alhTHUPdaa+lyBfk7KAR7t5lTrNOsoVEprpXp3AcAjBozLa1R0YB
	nMxiSthA9OoxWHLqt16HAZi8iDV5wAakxM+3HKNIKFjFkwfBiXD9GEwGkDuDfZ+IGiUDShd8DWn
	ZwLXKANw==
X-Received: by 2002:a17:90b:33c8:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-37d15fb0ae4mr892055a91.0.1781814114148;
        Thu, 18 Jun 2026 13:21:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15de501asm521508a91.11.2026.06.18.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:21:53 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:21:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 7.2
Message-ID: <ajRTHKxu6EOmGrsQ@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Regular development statistics update, similar Jakub's netdev post:
https://lore.kernel.org/netdev/20260617115319.43a5942d@kernel.org/

Previous cycle:
8 Feb to 13 Apr: 8105 mailing list messages, 63 days, 129 messages per day
587 repo commits (9 commits/day, 45.83% of these are selftests)
https://lore.kernel.org/bpf/aeADR0h4R4MlfUxe@devvm17672.vll0.facebook.com/

Current cycle:
12 Apr to 14 Jun: 8289 mailing list messages, 63 days, 132 messages per day
301 repo commits (5 commits/day, 44.85% of these are selftests)

Testing
-------

Top contributors of selftests:
   1 [ 12] Amery Hung
   2 [ 12] Alexei Starovoitov
   3 [  9] Kumar Kartikeya Dwivedi
   4 [  9] Sun Jian
   5 [  8] Eduard Zingerman
   6 [  6] Mykyta Yatsenko
   7 [  6] Daniel Borkmann
   8 [  5] Emil Tsalapatis
   9 [  4] Paul Chaignon
  10 [  4] Varun R Mallya

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [11] Alexei Starovoitov      1 (   ) [26] Alexei Starovoitov  
   2 ( +2) [ 4] Jakub Kicinski          2 (   ) [11] Eduard Zingerman    
   3 ( +5) [ 3] Emil Tsalapatis         3 ( +4) [ 8] Emil Tsalapatis     
   4 ( +2) [ 3] Mykyta Yatsenko         4 ( +1) [ 8] Jakub Kicinski      
   5 ( -3) [ 3] Kumar Kartikeya Dwivedi    5 ( -1) [ 6] Andrii Nakryiko     
   6 (+14) [ 3] Jiayuan Chen            6 (+26) [ 6] Stanislav Fomichev  
   7 ( +5) [ 2] Yonghong Song           7 ( -1) [ 6] Mykyta Yatsenko     
   8 ( -1) [ 2] Eduard Zingerman        8 ( -5) [ 6] Kumar Kartikeya Dwivedi
   9 ( -6) [ 1] Andrii Nakryiko         9 ( +7) [ 5] Yonghong Song       
  10 (+30) [ 1] Paolo Abeni            10 ( +7) [ 5] Jiayuan Chen        
  11 ( -2) [ 1] Martin KaFai Lau       11 (+36) [ 4] Paul Moore          
  12 ( -1) [ 1] Paul Chaignon          12 ( +2) [ 3] Steven Rostedt      
  13 (+10) [ 1] Stanislav Fomichev     13 (***) [ 3] Andrew Lunn         
  14 (***) [ 1] Leon Hwang             14 ( -5) [ 3] Martin KaFai Lau    
  15 ( +6) [ 1] Daniel Borkmann        15 (+13) [ 3] Kuniyuki Iwashima   

Top authors (cs):                    Top authors (msg):                  
   1 ( +5) [1] Daniel Borkmann          1 ( +2) [22] Jiri Olsa           
   2 (***) [1] Sechang Lim              2 ( +6) [21] Yonghong Song       
   3 ( +7) [1] Puranjay Mohan           3 (***) [15] Ian Rogers          
   4 (***) [1] Amery Hung               4 (   ) [13] Mykyta Yatsenko     
   5 ( -1) [1] Alexei Starovoitov       5 (+17) [11] Ricardo B. Marlière 
   6 (+11) [1] Tiezhu Yang              6 (***) [10] Jason Xing          
   7 (***) [1] Dipayaan Roy             7 (***) [ 9] Leon Hwang          
   8 (+13) [1] Yonghong Song            8 (***) [ 9] Amery Hung          
   9 ( +5) [1] Paul Chaignon            9 (***) [ 8] Jens Remus          
  10 ( +5) [1] Jiri Olsa               10 ( -4) [ 7] Eduard Zingerman    

Top scores (positive):               Top scores (negative):              
   1 (   ) [184] Alexei Starovoitov     1 (***) [72] Jiri Olsa           
   2 ( +1) [ 49] Jakub Kicinski         2 (***) [58] Ian Rogers          
   3 ( -1) [ 30] Andrii Nakryiko        3 (+13) [47] Yonghong Song       
   4 ( +5) [ 30] Stanislav Fomichev     4 ( +4) [43] Ricardo B. Marlière 
   5 (+20) [ 27] Emil Tsalapatis        5 (***) [38] Jason Xing          
   6 ( -1) [ 24] Kumar Kartikeya Dwivedi    6 (***) [33] Jens Remus          
   7 (***) [ 21] Jiayuan Chen           7 (+46) [25] Daniel Machon       

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [21] Meta                    1 (   ) [65] Meta                
   2 ( +1) [ 5] Google                  2 (   ) [15] Google              
   3 ( +2) [ 4] RedHat                  3 ( +5) [ 9] RedHat              
   4 ( +2) [ 4] Shopee                  4 ( -1) [ 8] Isovalent           
   5 ( -3) [ 4] Isovalent               5 ( -1) [ 6] Intel               
   6 ( -2) [ 3] Intel                   6 ( -1) [ 6] Shopee              
   7 ( +1) [ 1] SUSE                    7 (   ) [ 4] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [8] Meta                     1 (   ) [92] Meta                
   2 ( +2) [4] Google                   2 ( +9) [35] Google              
   3 ( -1) [4] Isovalent                3 (   ) [33] Isovalent           
   4 ( -1) [2] Shopee                   4 ( +1) [14] Shopee              
   5 (+11) [1] Microsoft                5 ( +5) [12] IBM                 
   6 ( +2) [1] Amazon                   6 (+16) [11] Tencent             
   7 (***) [1] Seoul National University    7 ( +5) [11] SUSE                

Top scores (positive):               Top scores (negative):              
   1 (***) [57] RedHat                  1 (+49) [72] Isovalent           
   2 ( -1) [27] Meta                    2 (***) [49] Google              
   3 (***) [22] Intel                   3 ( +1) [43] IBM                 
   4 ( -1) [10] Hedgehog                4 (***) [36] Tencent             
   5 (   ) [10] Linux Foundation        5 (+17) [25] Microchip           
   6 (+44) [ 9] Andrew Lunn             6 (***) [22] Microsoft           
   7 (***) [ 8] CloudFlare              7 (***) [20] SUSE                

More raw stats
--------------

Prev: start: Sun, 08 Feb 2026 20:59:08 -0800
	end: Mon, 13 Apr 2026 04:49:20 +0000
Prev: messages: 8105 days: 63 (129 msg/day)
Prev: direct commits: 587 (9 commits/day)
Prev: test commits: 269 (45.83%)
Prev: people: 402  {'author': 116, 'commenter': 207, 'both': 79, 'none': 25}
Prev: people pct: {'author': 0.272, 'commenter': 0.485, 'both': 0.185, 'none': 0.059}
Prev: review pct: 45.32%  x-corp pct: 40.72%
Prev: avg revisions: single patch: 1.48 patch set: 2.63

Curr: start: Sun, 12 Apr 2026 22:50:13 +0000
	end: Sun, 14 Jun 2026 21:02:35 +0000
Curr: messages: 8289 days: 63 (132 msg/day)
Curr: direct commits: 301 (5 commits/day)
Curr: test commits: 135 (44.85%)
Curr: people: 343  {'author': 144, 'commenter': 131, 'both': 68, 'none': 25}
Curr: people pct: {'author': 0.391, 'commenter': 0.356, 'both': 0.185, 'none': 0.068}
Curr: review pct: 44.85%  x-corp pct: 39.53%
Curr: avg revisions: single patch: 1.44 patch set: 2.35

Diff: -65.6% linux-next size
Diff:  +2.3% (+197.1%) msg/day
Diff: -48.7% (+49.0%) commits/day
Diff: -14.7% (+147.9%) people/day
Diff: review pct: -0.5%
      x-corp pct: -1.2%
Diff: avg revisions: single patch: -2.6% patch set: -10.5%
