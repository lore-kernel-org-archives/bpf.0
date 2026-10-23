Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795759;
	b=vIXryb+2l6ZrKnM6NQvxYZxP3gN/xTg5EJ0e9aSzet0Q93zc4wWxDzvFsj8QJV2n05jQ
	 DKcAR2cXMoW+NhUqeFbswX1nraUOgUVgmL2W6vHyM1DkmVNH2EbmwNLE4Zk73E5CaWhrQ
	 AqPClVia7+vBo7ZtaBKV+C/LREnZ6wy82Deks4IPuUReiqTfe8K4I1nyfWDlGt9HhQnOW
	 qR18RiHcXJJVeGY4ju5zKlmpoV6ZUhYun/SgvlPa7t4DfJG7iIdqHL4gY+0hcEDS7CORi
	 Yljxr04I5bYbAlb14q0mJmJ7tU7mabvOCts/gi2TbYZ8qWB0AZQTuZ4FeSmLKNugjkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=wf2xiz2PFexWFbgPLsJKSE61ITQ/2cwZygWHOiTpFaA=;
	b=pr7j4rx4HgJxfjLTspoO4qT7GJStsfNt03Szk+0tcP4XbU/mj6LR4AyQC7qAjSGs8Mcj
	 YODLnJsx010i0SjJRz7Y7aP//qG2W352H5MzvAXzWpKxah+PnAo3yfnKtramicFET8d9L
	 V1nXLPd85RjnWvBKdkC3cjR8lcc1H8pzS3kMwh1E7kyQqAj9YJyMigjq2PXmEOs7tcAVi
	 rx2A4F3NzujvASysETYHrnwLFY0+4Myd2uFAI46QPphsx+7A6i2ZJJCPtP3CB6bBBcEQE
	 DtRqou0YDXOIMrGl4L4Rx3C2KImQBW7U9oJW09cSMjuwlsjM6ExxFiM52cXI0+2OQWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVLxxgE7;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA426606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA426606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVLxxgE7
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-35943f55c06so1707922eec.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795758; x=1793400558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wf2xiz2PFexWFbgPLsJKSE61ITQ/2cwZygWHOiTpFaA=;
        b=dVLxxgE7CMVzFrM0IzOBkzDvvkY/Qh5CGEX6of7WNhJ8T6hK7waSlD47b0m3a7JWbk
         +iO5LeupHUPvkcGGBAHeUbQwWTmSy+TBYF0jSd1gul6Igu4mbV6pzkETtgX1SKyE5l5K
         xq2GnE5k0+SYbO6nVg1l+7g2Or+CHmRNq21D8gC0oZxAaSh6A9VKuncvqFQvgnu2dOwh
         vhQWSW4WtX6b8pt82YVsCmx5Ne9PtQpHV6CwtsFCL8X1139uVXT4TlgU75YMo8L86hbM
         1dwYMD3nVu7acldFDkduWcbI0dbueRrB6gCRETIOO2QxC06EY5IMyQPD+9MZcBuSmYCE
         QAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795758; x=1793400558;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf2xiz2PFexWFbgPLsJKSE61ITQ/2cwZygWHOiTpFaA=;
        b=vwh5uFB2t3xZBPeJ6xZT2UqeSOYBJrZYeCHRsr+E/Ht6nxq9VD4coF0M5j9TUd7Ebd
         a+J4XRoWtZq0eRFsq0KiimfXlLzbBUNCcGuRUg3+2O5SFY7bC1FB26dkl1QeLIzYit/O
         YjJfCV86Xq1SQEoFipeIZvhns2z2xunl81GcrPDiIMRycVUmJh7vVhDO0YNypvf5+Mm9
         wYQAzjM7s6Jg0xHTWPq/Z+1bO6PKtmZ4YKn8GTE+9FEYsmQkg8Yg887nyW+agi0Kf5Jr
         uN2W0bNsSc6vz8wz8fjDc4xEIJt98NbltD+MwBQN4KEDPRYgj4fDgcVj303w3Nc0DlA0
         zyAA==
X-Gm-Message-State: AFq9FYIRF/yeoqVKX9GLIkXet7CUoXRy+wlArmCMb081giKJ4zLdW48j
	tgmta2Tf4+vhFhiOU/BsgKkprylD5ZpDq2EOBR/cLHvLaRze8assehz0Ts3iYHCxruM=
X-Gm-Gg: AYBFou0ukqnv4CeHTwzM0Ocqt0ZXJpSgtQKf2xNG8yWbuXrFidk9wm5LEJPGw1ZOX26
	PDJDZag5ZuJwHrFhS3dJKwN8DY01HpR8WtK2f4KMj2ch6gLXcrQfdUzwbACYcKHThWQr1SRzSBT
	A0WE7fD1SmFmz/JLVueBkUvFb5L8GrygPGWqQvbbQ9odz8pU6v42YAkGxaq+DcFE4259WZ1n4q0
	i5NG5NSbonqcjt0KDHy8yKXydl2csBZWUnC5V3qrFIvpMMHY1X34N3Gydxn0E00bTfe+LiMYnWj
	f8kSrcwS7I5/uh6MwSC+P+xirPjO2yEhHzSXc1yvj0tpqopjkiYagsdWIZnla+Roj1mweF6fCjv
	dRySukU8KYn2u6G5fQB+bCjqTQiHTB0YtocpKjzxW+Do7fg4trNSMADiAq5waaet1Ng/b+Fq5k4
	tGB0MqIuXxvoWF0VV6yypOK8nr+XOYyeh+xkpzs0MxjwAenddJxx4ZhBVtdyleJm2r0BezWmYbe
	hGCzf9lB7Cu42hzgJXJMc6ZNScte1aflttbZvrz6jE/Tb2XBeytDCC5kCPrwRCDPR5yBsI=
X-Received: by 2002:a05:7301:4615:b0:363:a45d:10b1 with SMTP id 5a478bee46e88-369e8483999mr868444eec.5.1792795757535;
        Fri, 23 Oct 2026 15:49:17 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm1798899eec.25.2026.10.23.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:49:17 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:49:09 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 7.4
Message-ID: <atvjtQPh7bRZcVNi@devvm16445.scu0.facebook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Regular development statistics update, similar to Jakub's netdev post:
https://lore.kernel.org/netdev/20261022135723.07412855@kernel.org/

This cycle, because Jakub added a few new stats, I used this as an opportunity
to run my own generation scripts through an LLM, which obviously found
a few bugs: the git commit ranges have been off since at least 6.14, and
since the MAINTAINERS update for the general BPF entry, the commits
applied by the new maintainers were left out. See "Corrected history"
below for the details and the fixed numbers.

Previous cycle:
15 Jun to 17 Aug: 8618 mailing list messages, 63 days, 137 messages per day
433 repo commits (7 commits/day, 36.26% of these are selftests)
https://lore.kernel.org/bpf/aoen96RONJgf18E5@devvm7509.cco0.facebook.com/

Current cycle:
17 Aug to 21 Oct: 12765 mailing list messages, 65 days, 196 messages per day
815 repo commits (13 commits/day, 41.6% of these are selftests)

Highlights
----------

This part is written by an LLM, I'm extending my workflow to compare
the previous and the current cycle to find interesting tidbits:

 - Review coverage dropped sharply: only 26% of the commits carry
   a Reviewed-by / Acked-by (64% in 7.3, 44-64% in every cycle since
   6.14), 7% ahead of the maintainer's sign-off. Maintainers wrote more
   of the commits themselves (44% vs 24%), but patches from everyone
   else are down too, from 67% to 33% with a review tag.
 - Everything grew: 44% more messages per day, 76% more patch postings,
   almost twice as many commits (815 vs 433). Bots sent 25% of the
   messages (20% in 7.3), netdev's AI reviewer now also replies to the
   patches cross-posted to netdev (301 replies).
 - 70 authors had no earlier commit in the kernel, 27% of all authors
   (46 and 22% in 7.3), and 57 people contributed selftests (43).
 - Alexei is back as the top reviewer (365 review messages, 61 in 7.3),
   and more reviews come from the neighboring subsystems, e.g. David
   Hildenbrand (18 -> 85) and Tejun Heo (17 -> 68).

Testing
-------

Top contributors of selftests:
   1 [ 53] Kumar Kartikeya Dwivedi
   2 [ 44] Eduard Zingerman
   3 [ 32] Alexei Starovoitov
   4 [ 24] Daniel Borkmann
   5 [ 20] Yonghong Song
   6 [ 15] Amery Hung
   7 [ 13] Emil Tsalapatis
   8 [ 11] Qiliang Yuan
   9 [ 11] Ihor Solodrai
  10 [ 10] Jiayuan Chen

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +4) [19] Alexei Starovoitov      1 ( +4) [41] Alexei Starovoitov  
   2 ( +2) [ 5] Andrii Nakryiko         2 ( -1) [15] Eduard Zingerman    
   3 (   ) [ 4] Kumar Kartikeya Dwivedi    3 ( -1) [11] Andrii Nakryiko     
   4 ( -3) [ 4] Eduard Zingerman        4 (+23) [ 9] David Hildenbrand (Arm)
   5 ( +1) [ 4] Jakub Kicinski          5 ( -1) [ 8] Kumar Kartikeya Dwivedi
   6 ( -4) [ 3] Emil Tsalapatis         6 (+22) [ 8] Tejun Heo           
   7 ( +5) [ 3] Tejun Heo               7 ( +1) [ 7] Jakub Kicinski      
   8 ( +7) [ 2] Amery Hung              8 ( +6) [ 7] Amery Hung          
   9 (+14) [ 2] Quentin Monnet          9 ( +1) [ 6] Stanislav Fomichev  
  10 ( -1) [ 2] Jiri Olsa              10 (+28) [ 5] Quentin Monnet      
  11 ( -1) [ 2] Ihor Solodrai          11 ( -8) [ 5] Emil Tsalapatis     
  12 ( -4) [ 2] Daniel Borkmann        12 ( -1) [ 4] Jiri Olsa           
  13 (+19) [ 2] Simon Horman           13 (+39) [ 4] Simon Horman        
  14 ( -3) [ 2] Jiayuan Chen           14 (+15) [ 4] Björn Töpel         
  15 (+20) [ 1] Mykyta Yatsenko        15 ( -8) [ 4] Leon Hwang          

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [3] Kumar Kartikeya Dwivedi    1 (   ) [49] Kumar Kartikeya Dwivedi
   2 (***) [2] Alexei Starovoitov       2 ( +1) [48] Yonghong Song       
   3 (***) [2] Qiliang Yuan             3 (+41) [27] Lorenzo Stoakes (ARM)
   4 ( +3) [2] Jiayuan Chen             4 (***) [26] Alexei Starovoitov  
   5 (***) [2] Eduard Zingerman         5 (+13) [22] Eduard Zingerman    
   6 ( +8) [2] Yonghong Song            6 ( -1) [15] Daniel Borkmann     
   7 ( -1) [2] Daniel Borkmann          7 (+12) [13] Emil Tsalapatis     
   8 (***) [1] Karl Mehltretter         8 (***) [12] Josef Bacik         
   9 (+10) [1] <chenyuan_fl@163.com>    9 (***) [11] Alan Maguire        
  10 (***) [1] Lorenzo Bianconi        10 ( -6) [11] Amery Hung          

Top scores (positive):               Top scores (negative):              
   1 ( +3) [210] Alexei Starovoitov     1 (   ) [191] Yonghong Song      
   2 (   ) [ 79] Andrii Nakryiko        2 (+20) [127] Kumar Kartikeya Dwivedi
   3 ( +2) [ 54] Jakub Kicinski         3 (***) [101] Lorenzo Stoakes (ARM)
   4 ( +7) [ 50] Tejun Heo              4 (***) [ 49] Josef Bacik        
   5 (+17) [ 44] Quentin Monnet         5 (***) [ 37] Tao Cui            
   6 (+15) [ 35] David Hildenbrand (Arm)    6 ( +5) [ 34] Daniel Borkmann    
   7 ( +1) [ 29] Stanislav Fomichev     7 ( +7) [ 29] Harshitha Ramamurthy

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [23] Meta                    1 (   ) [63] Meta                
   2 ( +3) [19] Anthropic               2 ( +4) [39] Anthropic           
   3 ( +3) [ 5] RedHat                  3 ( +2) [19] RedHat              
   4 ( -2) [ 4] Isovalent               4 ( -2) [10] Google              
   5 ( -2) [ 3] Google                  5 ( -2) [ 8] Isovalent           
   6 ( +1) [ 3] Intel                   6 ( +3) [ 7] Intel               
   7 ( -3) [ 3] Shopee                  7 ( -3) [ 7] Shopee              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [11] Meta                    1 (   ) [164] Meta               
   2 (***) [ 3] Anthropic               2 (***) [ 40] Anthropic          
   3 ( +3) [ 3] Isovalent               3 (+13) [ 32] ARM                
   4 ( +1) [ 2] Google                  4 ( -2) [ 26] Isovalent          
   5 ( -2) [ 2] Shopee                  5 ( +2) [ 26] Google             
   6 (***) [ 2] Qiliang Yuan            6 ( +2) [ 17] Microsoft          
   7 ( +1) [ 2] Microsoft               7 ( +4) [ 15] Oracle             

Top scores (positive):               Top scores (negative):              
   1 ( +1) [142] Anthropic              1 (***) [249] Meta               
   2 ( +4) [ 49] RedHat                 2 (+35) [114] ARM                
   3 ( +7) [ 44] Hedgehog               3 ( -2) [ 48] Kylin Software     
   4 ( +3) [ 24] nVidia                 4 (***) [ 44] Google             
   5 (+10) [ 20] Eric Dumazet           5 ( -1) [ 40] Amazon             
   6 ( +3) [ 16] Linux Foundation       6 ( -1) [ 40] Microsoft          
   7 ( -3) [ 13] SUSE                   7 ( -4) [ 38] Isovalent          

Posting efficiency
------------------

New this time: how many patch postings it takes to get a commit merged.
4748 postings turned into 1011 commits this cycle, 4.70 postings per
commit (2.23 counting only the postings which got merged). Companies
best / worst at getting code into the tree:

Lowest postings/commit (min 10):     Highest postings/commit (min 10):   
   1 [123@ 2.72] Anthropic              1 [ 14@ 8.29] RedHat             
   2 [ 78@ 2.74] Isovalent              2 [ 34@ 8.03] ARM                
   3 [ 49@ 2.88] Microsoft              3 [ 17@ 5.18] Kylin Software     
   4 [ 10@ 3.70] <chenyuan_fl@163.com>    4 [ 24@ 5.12] Oracle             
   5 [ 11@ 3.73] Qiliang Yuan           5 [ 13@ 4.92] Huawei             
   6 [362@ 3.73] Meta                   6 [ 24@ 4.71] Shopee             
   7 [ 15@ 3.87] Microchip              7 [ 50@ 4.14] Google             
       ^     ^
 number of   postings per
  commits    1 commit

Nothing merged, people (min 30):     Nothing merged, companies (min 30): 
   1 (***) [  63] Justin Suess          1 (***) [  63] Justin Suess      
   2 (***) [  37] Jay Wang                                               
   3 (***) [  35] Gabriele Monaco                                        
   4 (***) [  33] Andrey Grodzovsky                                      
   5 ( -1) [  32] Ankur Arora                                            

AI review replies
-----------------

Also new: share of each author's postings the review bots replied to
(replies to cover letters count too, so it can go over 100%).

Replies from sashiko-bot@kernel.org: 1427
Per posting, people (min 10):        Per posting, companies (min 30):    
   1 [100% of  27] Ricardo Robaina      1 [81% of 273] ARM               
   2 [100% of  26] Mauricio Faria de Oliveira    2 [70% of 141] Microsoft         
   3 [100% of  10] Mickaël Salaün       3 [50% of 116] RedHat            
   4 [93% of  14] Matt Turner           4 [47% of  34] Crowdstrike       
   5 [90% of  20] Ratheesh Kannoth      5 [42% of  67] Tao Cui           
   6 [84% of 237] Lorenzo Stoakes (ARM)    6 [42% of  84] Amazon            
   7 [83% of  12] Jason Xing            7 [39% of  41] Vineet Gupta      
   8 [74% of  19] Kees Cook             8 [38% of  88] Kylin Software    
   9 [73% of  26] Wei Hu                9 [38% of  40] Qualcomm          
  10 [72% of  18] Zhen Ni              10 [35% of  37] <chenyuan_fl@163.com>

Replies from bot+bpf-ci@kernel.org: 1041
Per posting, people (min 10):        Per posting, companies (min 30):    
   1 [93% of  14] Fuyu Zhao             1 [59% of  34] Crowdstrike       
   2 [75% of  16] Xu Kuohai             2 [54% of  37] <chenyuan_fl@163.com>
   3 [61% of  33] Andrey Grodzovsky     3 [46% of  39] Tianyi Chen       
   4 [58% of  12] Florent Revest        4 [37% of  41] Vineet Gupta      
   5 [56% of  16] Ziyang Men            5 [35% of 214] Isovalent         
   6 [54% of  37] <chenyuan_fl@163.com>    6 [35% of 123] Oracle            
   7 [54% of  28] Hui Zhu               7 [35% of 113] Shopee            
   8 [50% of  14] Mykyta Yatsenko       8 [33% of  64] Huawei            
   9 [50% of  12] Mingpei CAO           9 [27% of  84] Amazon            
  10 [50% of  10] Thiébaud Weksteen    10 [27% of  63] Justin Suess      

Corrected history
-----------------

What was wrong with the previous reports:
 - the git stats used wrong commit ranges: the cutoffs were picked by
   date in the bpf-next history, which has mainline merged in, so they
   landed on random commits from other trees (realistically, was not
   affecting the bottom line); they now cover exactly the work between
   the bpf-next pull requests to Linus,
 - commits applied by the new maintainers were left out of the counts,
 - the linux-next size used to normalize the 7.2 and 7.3 trends was
   slightly off,
 - bots and stable backports weren't fully filtered out of the mailing
   list stats (e.g. kernel test robot replies counted as Intel reviews).

7.2 and 7.3 were regenerated completely, for the older cycles only the
git based numbers below were recomputed:

Release  commits    selftests  reviewed       x-company  any review
         (posted)              (posted)                  tag
6.14     222 (378)  45.0%      32.0% (23.5%)  25.7%      52.7%
6.15     205 (337)  51.7%      21.5% (25.5%)  20.5%      52.2%
6.16     183 (183)  34.4%      32.2% (23.4%)  31.1%      52.5%
6.17     206 (376)  41.7%      37.4% (31.9%)  28.2%      55.8%
6.18     227 (437)  37.0%      24.7% (30.7%)  19.8%      49.8%
6.19     218 (415)  44.5%      46.3% (36.4%)  33.9%      59.2%
7.0      309 (205)  39.2%      37.2% (42.4%)  34.3%      52.1%
7.1      320 (587)  50.6%      48.1% (45.3%)  41.6%      55.9%
7.2      398 (301)  42.0%      36.4% (44.9%)  31.7%      44.0%
7.3      433 (377)  36.3%      36.7% (36.9%)  27.7%      64.4%
7.4      815        41.6%       7.0%           5.4%      25.5%

"reviewed" is the share of commits with a review tag ahead of the
maintainer's sign-off, "any review tag" counts a tag anywhere in the
commit message.

With the fixes, some of the 7.3 trends turned out to be artifacts:
commits per day grew 9% (not 25%), review coverage stayed flat at 36.7%
(rather than dropping 8%), and patch sets needed 12% fewer revisions
(not 31% more).

More raw stats
--------------

Prev: start: Mon, 15 Jun 2026 11:20:10 -0700
	end: Mon, 17 Aug 2026 23:26:22 +0200
Prev: messages: 8618 days: 63 (137 msg/day)
Prev: bot messages: 1719 (19.95%)
Prev: direct commits: 433 (7 commits/day)
Prev: test commits: 157 (36.26%)
Prev: people: 338  {'author': 153, 'commenter': 128, 'both': 57, 'none': 9}
Prev: people pct: {'author': 0.441, 'commenter': 0.369, 'both': 0.164, 'none': 0.026}
Prev: review pct: 36.72%  x-corp pct: 27.71%
Prev: avg revisions: single patch: 1.65 patch set: 2.98
Prev: postings per merged commit: 4.82 (merged postings only: 2.20)
Prev: postings: 2691 merged: 1230 commits: 558
Prev: postings with Fixes: 677 (25.16%) merged: 357 (29.02%)

Curr: start: Mon, 17 Aug 2026 16:27:29 -0500
	end: Wed, 21 Oct 2026 21:01:45 +0000
Curr: messages: 12765 days: 65 (196 msg/day)
Curr: bot messages: 3124 (24.47%)
Curr: direct commits: 815 (13 commits/day)
Curr: test commits: 339 (41.6%)
Curr: people: 417  {'author': 177, 'commenter': 155, 'both': 85, 'none': 12}
Curr: people pct: {'author': 0.413, 'commenter': 0.361, 'both': 0.198, 'none': 0.028}
Curr: review pct: 6.99%  x-corp pct: 5.4%
Curr: avg revisions: single patch: 1.82 patch set: 3.09
Curr: postings per merged commit: 4.70 (merged postings only: 2.23)
Curr: postings: 4748 merged: 2258 commits: 1011
Curr: postings with Fixes: 1025 (21.59%) merged: 597 (26.44%)

Diff: +16.3% linux-next size
Diff: +43.6% (+23.4%) msg/day
Diff: +82.4% (+56.8%) commits/day
Diff: +19.6% ( +2.8%) people/day
Diff: review pct: -29.7%
      x-corp pct: -22.3%
Diff: avg revisions: single patch: +10.8% patch set: +3.7%
