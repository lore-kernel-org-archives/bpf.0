Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AE3491C9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288672; cv=none; b=Oqcn2yMoQp1PvhHYUY0TjmjuRfOgw8JLutzo7hUQ5UXEcBIStWLUuPZcGlFVchuoUnkG2ek+giEnCUWpT2y7IEyOcoR8f9UgzrR71+pssLg6ovXMhHUWIFSlnGFwHJ9mHnJbUYRXfN8n8YquBtsIpEiSN90sZfSzVlS6pDh6RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288672; c=relaxed/simple;
	bh=E9vFpTDiV/pr8Ng18SsqCyhT+ZqVSXk0SG4287rzXOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r6s4nEqFeLZNG0EpeuZWTGeFrMwv3kx6gy+bSCVLZMU1QuxXDSkn3ySACC2SNn7bdPzMYXDpetQYfjmfejzQLfuF618yTB670K23POk4gaKjb0u7iLX3lW3SAF2zeaIApBp3DS26PCUGSkc9GARcIc1DQdFJGgI1NEwtukMzwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieh1k7cb; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieh1k7cb"
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-67e0d3f288aso4667162eaf.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776288669; x=1776893469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5A52EZzIpB5adk9fTKF+OWANNyhT/jkHlG9AmSCffU=;
        b=ieh1k7cb+/7tPnAurIcyhC7JecrJ6ZmvMIJLuqVEXkIyNweMB/2RUI79imefEWmARp
         62ZN3+cLz1ZiJQbmVyvLMo7l2JN1m1PJ0AqKWXrcv7PczQbk/xzpZw7FDvqJzX6RiVk0
         FkqRhgh1oiDryduIRyX28ywiP3o3BkNrLXztgzshgSCro5GEOnxRMz0BsE+S8wbvvHge
         kFJBCufTVzId2ZzCi5vadxIAj1nHY5mqbbHxtK5EKMe01GsC/zQTkGPAdanH8+9rmD/k
         EvBTvYLP+aVock/WWs+WT1qkI9LgBZSKhli05/rtYde2hIjzZATSZd94k1wGbQFkimLT
         Y/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776288669; x=1776893469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5A52EZzIpB5adk9fTKF+OWANNyhT/jkHlG9AmSCffU=;
        b=BDxCEW5KKI9C3lrfOwJ1Ln8IagKimfoTtiktd1np57xhHQD31Kg1F3B4xWZnkDPbLs
         9nGC1BOhg5K7YDBCOjU1QJRxQ0lXkALtnhJVaUdnESBZCqPEmUOlI5BHBvyNGceLtxDH
         E28w3zjVRvOQFzz3MXWOl18IZSN8AmosFHpWEUTFM24k8mZn8tDR8eVsvwwWkt3MXLn+
         aGZYuTxaAp/YID8DIMjQ/3Z7PfCFYh5nyxr0E37VdbeWZ22h2g9Qxzi71U6JEXw19Cdo
         xfHRCohmbBUeb0YCHhwXeqCubvD4PghYpR6ERucAfB04xyQ+od71DKy8TUM6okoWYph8
         3ZZg==
X-Gm-Message-State: AOJu0YwAwAVCf1Yzx+LgDgykveJWN0lhE4QwdvVENP3mthgsKxxKpfIl
	hQGzoe0F7nKjYUCm93g1Yj3cM0eF/BNuhBgCweBRNvwcibq6PxvUzZgL82IjFeup
X-Gm-Gg: AeBDietz43Q7iWxEEqWgh8l8ZdLbAWxjJUgWXarGBtDZIJqcJJaKih89cVy0Xw5yOHs
	gJzewjRttk+4lg+kH1mPaXponcIpATSjq1a7XtdEQ/34kwghwHM0DCvMNK1KCTMJH7ZCZauX3nn
	qEhSgXEHpmCzkUbfm1oPaFmzPefnAzNlEw7Te92CBrtvOftLTB6P8l+kwdJckAv+1jJ9iJeWAHO
	bMGGgLZbFv9rwp2wz4Uv5J600x6XcfJNdWbNJl+3H2PgsQPxu3+9P/32I0OSYNLPTzuj8IiEw4q
	1L1bGQsu+EqkOjzIkdgQNYOS1HaQfblxlDMB/PLJxZXim3lUkzzESgIa/cv5lKNs7h89eGD6iCC
	q58+kcmIkCYGNw5crjZlUQozDxtQesykXISzAe9G4FhyHF+ogVhrgL7H7DWyoGhdhM/mN1przZh
	WPfZlJqqVdoPdC91pPeQ==
X-Received: by 2002:a05:6820:4c88:b0:67e:366b:a2b0 with SMTP id 006d021491bc7-68be5e56ca6mr12698474eaf.7.1776288669500;
        Wed, 15 Apr 2026 14:31:09 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6932b778ff7sm1465378eaf.7.2026.04.15.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:31:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:31:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 7.1
Message-ID: <aeADR0h4R4MlfUxe@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Regular development statistics update, similar Jakub's netdev post:
https://lore.kernel.org/netdev/20260414182653.40d84ccc@kernel.org/

If you're interested in doing similar comparison to 6.18, here
is a link and a bunch of stats:

    6.18 stats: https://lore.kernel.org/bpf/aOBHUT26KS86wx-n@mini-arch/

    <metric>       6.18 ->  7.1
    messages       5327 -> 8105
    messages/day     86 ->  129
    commits         437 ->  587
    people          281 ->  402

Previous cycle:
1 Dec to 8 Feb: 6133 mailing list messages, 69 days, 89 messages per day
205 repo commits (3 commits/day, 44.39% of these are selftests)
https://lore.kernel.org/bpf/aY7Beg9U_jEg8Iz1@mini-arch/

Current cycle:
8 Feb to 13 Apr: 8105 mailing list messages, 63 days, 129 messages per day
587 repo commits (9 commits/day, 45.83% of these are selftests)

Testing
-------

Top contributors of selftests:
   1 [ 38] Ihor Solodrai
   2 [ 18] Amery Hung
   3 [ 18] Puranjay Mohan
   4 [ 16] Alexei Starovoitov
   5 [ 13] Eduard Zingerman
   6 [ 12] Emil Tsalapatis
   7 [ 12] Menglong Dong
   8 [ 11] Mykyta Yatsenko
   9 [ 10] Kumar Kartikeya Dwivedi
  10 [  9] Sun Jian

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [13] Alexei Starovoitov      1 (   ) [31] Alexei Starovoitov  
   2 ( +4) [ 4] Kumar Kartikeya Dwivedi    2 ( +1) [15] Eduard Zingerman    
   3 ( -1) [ 4] Andrii Nakryiko         3 ( +7) [11] Kumar Kartikeya Dwivedi
   4 ( +1) [ 4] Jakub Kicinski          4 ( -2) [11] Andrii Nakryiko     
   5 (+21) [ 4] Jiri Olsa               5 ( -1) [ 9] Jakub Kicinski      
   6 ( +8) [ 3] Mykyta Yatsenko         6 (+17) [ 9] Mykyta Yatsenko     
   7 ( -4) [ 3] Eduard Zingerman        7 (+21) [ 8] Emil Tsalapatis     
   8 (+33) [ 3] Emil Tsalapatis         8 (+21) [ 8] Jiri Olsa           
   9 ( -2) [ 2] Martin KaFai Lau        9 ( -2) [ 6] Martin KaFai Lau    
  10 (+26) [ 2] Puranjay Mohan         10 (***) [ 6] Leon Hwang          
  11 (***) [ 2] Paul Chaignon          11 (***) [ 5] Puranjay Mohan      
  12 ( -8) [ 2] Yonghong Song          12 (***) [ 3] Paul Chaignon       
  13 (+30) [ 2] Leon Hwang             13 ( -8) [ 3] Aleksandr Loktionov 
  14 (***) [ 1] Sun Jian               14 ( -5) [ 3] Steven Rostedt      
  15 ( -2) [ 1] Ihor Solodrai          15 ( +5) [ 3] Song Liu            

Top authors (cs):                    Top authors (msg):                  
   1 (+10) [2] Sun Jian                 1 (***) [21] Darrick J. Wong     
   2 (***) [2] Jiayuan Chen             2 (***) [14] Jeff Layton         
   3 (   ) [2] Ihor Solodrai            3 ( +9) [14] Jiri Olsa           
   4 ( +3) [2] Alexei Starovoitov       4 ( +5) [12] Mykyta Yatsenko     
   5 (***) [1] Kumar Kartikeya Dwivedi    5 ( +3) [12] Ihor Solodrai       
   6 (+37) [1] Daniel Borkmann          6 (***) [11] Eduard Zingerman    
   7 ( -1) [1] Mykyta Yatsenko          7 (+11) [11] Emil Tsalapatis     
   8 ( +4) [1] Amery Hung               8 (+28) [11] Yonghong Song       
   9 (+47) [1] Eduard Zingerman         9 (***) [11] Leo Yan             
  10 ( -9) [1] Puranjay Mohan          10 ( +3) [10] Alan Maguire        

Top scores (positive):               Top scores (negative):              
   1 (   ) [197] Alexei Starovoitov     1 (***) [83] Darrick J. Wong     
   2 (   ) [ 69] Andrii Nakryiko        2 (***) [54] Jeff Layton         
   3 ( +1) [ 62] Jakub Kicinski         3 (***) [41] Leo Yan             
   4 ( +2) [ 42] Martin KaFai Lau       4 (+44) [33] Larysa Zaremba      
   5 ( +2) [ 36] Kumar Kartikeya Dwivedi    5 (***) [32] Kaitao Cheng        
   6 ( -3) [ 36] Eduard Zingerman       6 ( +2) [30] Ihor Solodrai       
   7 ( +1) [ 20] Steven Rostedt         7 (***) [28] Philipp Hahn        

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [23] Meta                    1 (   ) [85] Meta                
   2 ( +4) [ 7] Isovalent               2 (   ) [19] Google              
   3 ( +1) [ 4] Google                  3 ( +3) [14] Isovalent           
   4 ( -2) [ 4] Intel                   4 ( -1) [12] Intel               
   5 ( -2) [ 3] RedHat                  5 (+28) [10] Shopee              
   6 (+15) [ 3] Shopee                  6 ( +3) [ 9] SUSE                
   7 (+12) [ 2] Amazon                  7 ( -2) [ 8] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [11] Meta                    1 (   ) [102] Meta               
   2 ( +2) [ 3] Isovalent               2 ( +9) [ 44] Oracle             
   3 ( +3) [ 3] Shopee                  3 ( +1) [ 28] Isovalent          
   4 ( -2) [ 3] Google                  4 (+23) [ 20] Intel              
   5 ( +2) [ 2] IBM                     5 ( +2) [ 16] Shopee             
   6 ( +3) [ 2] RedHat                  6 (+10) [ 15] RedHat             
   7 ( +7) [ 2] Sun Jian                7 ( -4) [ 14] Amazon             

Top scores (positive):               Top scores (negative):              
   1 (   ) [78] Meta                    1 (+13) [131] Oracle             
   2 ( +3) [48] Google                  2 ( +7) [ 50] Kylin Software     
   3 ( +3) [17] Hedgehog                3 (***) [ 46] ARM                
   4 ( +5) [16] David Laight            4 ( -1) [ 31] IBM                
   5 ( -1) [14] Linux Foundation        5 (***) [ 28] AVM                
   6 (***) [10] Unknown                 6 (***) [ 23] Crowdstrike        
   7 ( +1) [ 7] nVidia                  7 ( -6) [ 21] Amazon             

More raw stats
--------------

Prev: start: Tue, 02 Dec 2025 15:09:42 +0800
	end: Sun, 08 Feb 2026 20:59:08 -0800
Prev: messages: 6130 days: 69 (89 msg/day)
Prev: direct commits: 205 (3 commits/day)
Prev: test commits: 91 (44.39%)
Prev: people: 310  {'author': 122, 'commenter': 132, 'both': 56, 'none': 22}
Prev: people pct: {'author': 0.367, 'commenter': 0.398, 'both': 0.169, 'none': 0.066}
Prev: review pct: 42.44%  x-corp pct: 31.22%
Prev: avg revisions: single patch: 1.44 patch set: 2.57

Curr: start: Sun, 08 Feb 2026 20:59:08 -0800
	end: Mon, 13 Apr 2026 04:49:20 +0000
Curr: messages: 8105 days: 63 (129 msg/day)
Curr: direct commits: 587 (9 commits/day)
Curr: test commits: 269 (45.83%)
Curr: people: 402  {'author': 116, 'commenter': 207, 'both': 79, 'none': 25}
Curr: people pct: {'author': 0.272, 'commenter': 0.485, 'both': 0.185, 'none': 0.059}
Curr: review pct: 45.32%  x-corp pct: 40.72%
Curr: avg revisions: single patch: 1.48 patch set: 2.63

Diff: +19.2% linux-next size
Diff: +44.8% (+21.4%) msg/day
Diff: +213.6% (+163.0%) commits/day
Diff: +42.0% (+19.1%) people/day
Diff: review pct: +2.9%
      x-corp pct: +9.5%
Diff: avg revisions: single patch: +2.9% patch set: +2.3%

Contributions to selftests: total individuals: 58 (was 31, +87.10%)
Contributions to selftests:
   1 [ 38] Ihor Solodrai
   2 [ 18] Amery Hung
   3 [ 18] Puranjay Mohan
   4 [ 16] Alexei Starovoitov
   5 [ 13] Eduard Zingerman
   6 [ 12] Emil Tsalapatis
   7 [ 12] Menglong Dong
   8 [ 11] Mykyta Yatsenko
   9 [ 10] Kumar Kartikeya Dwivedi
  10 [  9] Sun Jian
  11 [  9] Jiri Olsa
