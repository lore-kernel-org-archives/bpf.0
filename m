Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA12459E1
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275763; cv=none; b=COV8GwkzQYwer1ZRNuM+muV7/CZnkmTNHayrdZNHnTtHhbcsVkXNnoap8VKwTRozoowFm+jXWtNmFiMv+eSZF2/gSdrNHcLDxTFY3b/8jMLmtGEj4UlyBxuwH78BsEsjfWokKpD2KMZzoy20+fkMUz+rDMEnG/x52E2w9D6AEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275763; c=relaxed/simple;
	bh=TKoI37AZK2e3ysHnR9Rx+KS+32qGlXG1Dodbq7iZ35M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t2R5QNZx2tUfJ6WCpRU+uZy4WvQnDEXeOrZ+ZC9/L8TYCJu3M3nJZGCu51iiDQzw16U5+rxucotzUkAdYu1xNa4PNz5WbP9WX6QWNxLtGGg2kqCRnojeeOA5FONUx/QQdt4Ai3Nr5LS4OjE4YBkTdC/9UCLFFID8LTisDEZU/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWAI/BjT; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWAI/BjT"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so197507a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275761; x=1787880561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FeCBhBAUXf/tLk0qYkndIlPCAN8chjge4igus+QKKi8=;
        b=oWAI/BjTVZh1fNWtgfMY/m789dIXFLUivh6fEwEwCDoJkE2ZetRcjNFwDgMIyBbgtV
         r1doENKbYFy5UpXT6sJQvwy+WTQo0e1LCKq1pk9455xxGUq1dS+8GzQbos2wCg+zAJ6E
         Kc/2fmhKdzW7/hV0RahJpSGv8hj56MhDOrt2nTdvOFh2ezVIyA1NYwW98Ji4ElDjlDmX
         Wb5BG7qB2RM2JIgmqbkYFmIUazogRcympfOMCUmEhuM0h2KEi91sK8lQYPEcG56GH/TJ
         EuuWe5jFh+W0MGWqJ4qAf33J0UaqFNjoTIhImvGq9dUFoNd9BDqJgSCO/pfesevlAXiw
         mZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275761; x=1787880561;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FeCBhBAUXf/tLk0qYkndIlPCAN8chjge4igus+QKKi8=;
        b=luCj0WxcqYl5B2bN5lenf489iD3euaxFFDoKAYTV5m0zNciPuSfUYQEphVkA16dIY+
         +wi1x/DfCpu+lVDHYVB6gN09UVKoRpXy9+X3UYlaKzX1MfQxXKk0oXUsOit6SAHkZh2v
         W9mC+IqpMM5IjPFuyNJWWFnv8W5Nt4G3fKTLzwyHZKLwJwpOL+BQFQtgYVTq0vkpEb1H
         gNT7EIvsFVGF5hXpA20zHYi45TdZz6u+6TZIFjMlMk7rpsub7TrcJ4rQ9JNo5fNga0BG
         Qgpk5WNwE4w58sRfrBybDhB2o2R/aPrStHdaKBgdy5Ujqsg2oAL2KkoeYwKBi3lc4Haq
         itNw==
X-Gm-Message-State: AFuF++lWolvTotl16zyF04NS+RKU5b7/vVy7zdUcQNv4cEuSFnF5MncM
	wx2gT3ujkOW5NsrVsPjaWfYRR2vCnJgNvhLPGghgMnnXQQDNO+sBe6mmmpE3rKNE
X-Gm-Gg: AR+sD13Z0AYiFLCvcyp4ztLlK/X4Ok6vnKNYeBCv7gBGQcEZZ3Ttd9ZnXJUTENejGPq
	0bFGjOlq8Qq1vC/93/LKYtcQg5KTnQY6q0CeRP6x0uy0H9Jq8OTvjHgQlu4ksMlqffUTPs1Lt8W
	5pSUu8nP8daUX+VAvIfNilqc6BQEkWBoOT0P29kjq0U2eU7cNc6cNbysqtstfREJJsZuiLpm8kP
	E5uiE7cLHunjtoObejfGumA2+Tp271f/5tCQWYLXo1Sx9R840L5RXR8VpO5xmmF+tyOFutzCnSQ
	XhGExU/bxbpkmSih3bkcGdm/3sXeiaj+c2OKdwsa8fWC6ETXWkje3ZjFm+PBpv+YjSvVTMBEpmx
	ohkUHXynFCtNYU/cItesNw4cOyasBVtssCbH96o0EDRCGGUcclWRHUYUes9KGjfwgp7TwIMwyZ6
	hOdgYm87Ibr7iUkHRJDPAAdJ2MA6k1olVuDzBO5LE9y0qtVzpF0y7yRQ==
X-Received: by 2002:a17:90b:4a89:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-395c3511456mr4278855a91.4.1787275760703;
        Thu, 20 Aug 2026 18:29:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c47f7d78sm907703a91.9.2026.08.20.18.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:29:20 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:21:33 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 7.3
Message-ID: <aoen96RONJgf18E5@devvm7509.cco0.facebook.com>
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
https://lore.kernel.org/netdev/20260819114659.271292db@kernel.org/

Previous cycle:
12 Apr to 14 Jun: 8289 mailing list messages, 63 days, 132 messages per day
301 repo commits (5 commits/day, 44.85% of these are selftests)
https://lore.kernel.org/bpf/ajRTHKxu6EOmGrsQ@devvm7509.cco0.facebook.com/

Current cycle:
14 Jun to 16 Aug: 8596 mailing list messages, 63 days, 136 messages per day
377 repo commits (6 commits/day, 41.11% of these are selftests)

Testing
-------

Top contributors of selftests:
   1 [ 18] Emil Tsalapatis
   2 [ 14] Yonghong Song
   3 [ 13] Puranjay Mohan
   4 [ 12] Jiri Olsa
   5 [ 11] Ricardo B. Marlière
   6 [ 10] Amery Hung
   7 [  6] Leon Hwang
   8 [  6] Daniel Borkmann
   9 [  5] Mykyta Yatsenko
  10 [  4] Nuoqi Gui

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +7) [7] Eduard Zingerman         1 ( +1) [34] Eduard Zingerman    
   2 ( +1) [6] Emil Tsalapatis          2 ( +3) [13] Andrii Nakryiko     
   3 ( +2) [6] Kumar Kartikeya Dwivedi    3 (   ) [13] Emil Tsalapatis     
   4 ( +5) [6] Andrii Nakryiko          4 ( +4) [12] Kumar Kartikeya Dwivedi
   5 ( -4) [5] Alexei Starovoitov       5 ( -4) [ 8] Alexei Starovoitov  
   6 ( -4) [3] Jakub Kicinski           6 (+22) [ 6] Ihor Solodrai       
   7 ( +7) [3] Leon Hwang               7 (+22) [ 5] Leon Hwang          
   8 ( +8) [2] Jiri Olsa                8 ( -4) [ 5] Jakub Kicinski      
   9 (+10) [2] Ihor Solodrai            9 ( +2) [ 5] Paul Moore          
  10 ( -4) [2] Jiayuan Chen            10 ( -4) [ 4] Stanislav Fomichev  
  11 ( +4) [2] Daniel Borkmann         11 (+11) [ 4] Jiri Olsa           
  12 (***) [2] Tejun Heo               12 (***) [ 4] Pu Lehui            
  13 (***) [1] Pu Lehui                13 ( -3) [ 4] Jiayuan Chen        
  14 ( -1) [1] Stanislav Fomichev      14 (+20) [ 3] Amery Hung          
  15 (+29) [1] John Fastabend          15 (   ) [ 3] Kuniyuki Iwashima   

Top authors (cs):                    Top authors (msg):                  
   1 (+31) [2] Kumar Kartikeya Dwivedi    1 (+18) [24] Kumar Kartikeya Dwivedi
   2 (***) [2] Yiyang Chen              2 ( +5) [16] Leon Hwang          
   3 (***) [2] Pu Lehui                 3 ( -1) [13] Yonghong Song       
   4 ( +2) [2] Tiezhu Yang              4 ( +4) [13] Amery Hung          
   5 ( +8) [1] Leon Hwang               5 (+17) [12] Daniel Borkmann     
   6 ( +8) [1] Nuoqi Gui                6 ( +7) [11] Puranjay Mohan      
   7 ( +4) [1] Jiayuan Chen             7 (***) [11] Yiyang Chen         
   8 ( -7) [1] Daniel Borkmann          8 ( -7) [10] Jiri Olsa           
   9 (***) [1] Christian Brauner        9 (***) [10] Pu Lehui            
  10 (***) [1] Junseo Lim              10 (***) [ 9] Christian Brauner   

Top scores (positive):               Top scores (negative):              
   1 ( +7) [142] Eduard Zingerman       1 (***) [43] Yiyang Chen         
   2 ( +1) [ 91] Andrii Nakryiko        2 ( +1) [38] Yonghong Song       
   3 ( +2) [ 74] Emil Tsalapatis        3 (+10) [34] Puranjay Mohan      
   4 ( -3) [ 71] Alexei Starovoitov     4 (***) [33] Christian Brauner   
   5 ( -3) [ 38] Jakub Kicinski         5 (+18) [31] Mahe Tardy          
   6 (***) [ 21] Kuniyuki Iwashima      6 ( +2) [28] Amery Hung          
   7 (+24) [ 21] John Fastabend         7 ( +2) [25] Leon Hwang          

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [27] Meta                    1 (   ) [80] Meta                
   2 ( +3) [ 6] Isovalent               2 (   ) [12] Google              
   3 ( -1) [ 5] Google                  3 ( +1) [11] Isovalent           
   4 (   ) [ 5] Shopee                  4 ( +2) [ 9] Shopee              
   5 ( -2) [ 3] RedHat                  5 ( -2) [ 7] RedHat              
   6 (   ) [ 3] Intel                   6 ( +2) [ 7] SUSE                
   7 ( +2) [ 2] Huawei                  7 ( -2) [ 6] Intel               

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [8] Meta                     1 (   ) [82] Meta                
   2 ( +9) [4] Kylin Software           2 ( +1) [31] Isovalent           
   3 (+10) [3] Tsinghua University (THU)    3 ( +1) [21] Shopee              
   4 (   ) [3] Shopee                   4 (+10) [16] Huawei              
   5 ( -3) [2] Google                   5 (+11) [16] Tsinghua University (THU)
   6 ( -3) [2] Isovalent                6 ( +5) [14] Kylin Software      
   7 (+11) [2] Huawei                   7 ( +5) [12] Intel               

Top scores (positive):               Top scores (negative):              
   1 ( +1) [171] Meta                   1 (+10) [64] Tsinghua University (THU)
   2 (***) [ 39] Google                 2 ( +8) [56] Kylin Software      
   3 (***) [ 29] Stable team            3 ( -2) [37] Isovalent           
   4 (***) [ 22] SUSE                   4 ( +4) [34] Amazon              
   5 (***) [ 20] Tencent                5 (+15) [28] Huawei              
   6 ( +5) [ 15] nVidia                 6 (***) [25] Oracle              
   7 ( -2) [ 14] Linux Foundation       7 ( -1) [22] Microsoft           

More raw stats
--------------

Prev: start: Sun, 12 Apr 2026 22:50:13 +0000
	end: Sun, 14 Jun 2026 21:02:35 +0000
Prev: messages: 8289 days: 63 (132 msg/day)
Prev: direct commits: 301 (5 commits/day)
Prev: test commits: 135 (44.85%)
Prev: people: 343  {'author': 144, 'commenter': 131, 'both': 68, 'none': 25}
Prev: people pct: {'author': 0.391, 'commenter': 0.356, 'both': 0.185, 'none': 0.068}
Prev: review pct: 44.85%  x-corp pct: 39.53%
Prev: avg revisions: single patch: 1.44 patch set: 2.35

Curr: start: Mon, 15 Jun 2026 01:41:23 +0000
	end: Sun, 16 Aug 2026 16:56:36 -0700
Curr: messages: 8596 days: 63 (136 msg/day)
Curr: direct commits: 377 (6 commits/day)
Curr: test commits: 155 (41.11%)
Curr: people: 353  {'author': 165, 'commenter': 133, 'both': 55, 'none': 29}
Curr: people pct: {'author': 0.432, 'commenter': 0.348, 'both': 0.144, 'none': 0.076}
Curr: review pct: 36.87%  x-corp pct: 32.1%
Curr: avg revisions: single patch: 1.67 patch set: 3.10

Diff: +50.4% linux-next size
Diff:  +3.7% (-31.0%) msg/day
Diff: +25.2% (-16.7%) commits/day
Diff:  +2.9% (-31.6%) people/day
Diff: review pct: -8.0%
      x-corp pct: -7.4%
Diff: avg revisions: single patch: +15.9% patch set: +31.5%
