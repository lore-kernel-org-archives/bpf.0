Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D1944F
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963325; cv=none; b=DD9ejgFSnjPlSYzHXOmz3essl0Bf0ROGWoVDCEuiyJeQvhXVGTHma6LEclGmBtBBCq8ZRH5a502fIaKpF55QyK9LmAqh2tXmEWoC9L5s66FIgDMxw70kIBAfUaE6eFiNeha5YxqYyUZap6Dn2yDAan9fC22zMimXl2r8HOPJBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963325; c=relaxed/simple;
	bh=3lipCT2HxywmwAlwTT9F2ZYPT4Jh+fuPYFH5Sg22xwQ=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G5BdFQNJVGkjK2FoStFPVqeVDly3Usr1qanwWbHQsmduILtPKo51sptvvD0nFEaOHJMlF0vURfh8Gq1PUNJDibu182lsMPPO4bG07f3Sb69VsqL5gWsMJcg70MtMhE42060NNpEZ0e6kfRcuQEPxHqNYrL0qtvFOHH2NOR/iyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUNciswC; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUNciswC"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2baa6ec5638so283322eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 22:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770963323; x=1771568123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSnBEUwlsGlmG4S8Ga4XvSPQWvsOEXNThh4UUMWSecA=;
        b=UUNciswCkt3IYL2wtIrakjmxQiVTCfP8DLYcImmkMMTVS9+d18qRzLvayW+PbL/ig8
         CDbQo4u9U98JdZ2vF1j/AegsUdQH6B6kem/kKmesWIBfeSBqSo1wjxOZRoDW9f6jfAc4
         LSO35gwnJCHjY3qCBeI/azse8cvz6r+BvuhA9JllcrK41GtulbNSUy6evx9FUGKma85b
         ZicQvpKoWCjMeNjrR3yVe5Fv7AMtX2qasZCEX4XMxu5Gh9N+vTPO76kpv41hTvCEumNN
         g81yvmPonTgA/XNH2Nqoa7RT8eF5Lyqnf1Rwuxn6QChigycE3uPkLhWlNjXXiJrAhpsQ
         Kugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770963323; x=1771568123;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSnBEUwlsGlmG4S8Ga4XvSPQWvsOEXNThh4UUMWSecA=;
        b=hxOWXdpOrmmApfQZ3kBsTkwVljPsAwjJKNCUVgnMyY1hrWIJh/a/TdsE1dbuXqA7Hd
         UYbuUP3QSJmbgEJzpusC/aJC4cupJXFMi3Vj2N3kRDKhp6qQCHj1z0myq/DTne0TwYgA
         bNRBedaiPsKDxkV5+GsnZvWoBuWpCYVyb/74th4JSWS7fInkxT229mgU2CpUpybxNxMe
         ROCQVllaJYa83DHFY+5Q/PkNI5jMONsROnq3qM9FefXADAgMyelzdVFMqzCkjKIA8I+s
         BZAFg5sIYowS5o+lIk2FefwaNyBqywnz3+9VYtUta12U2+f4fwMzA9Hqy4VQLpKjyttT
         EBhw==
X-Gm-Message-State: AOJu0YzgVqV+83Zcwpt916l/cooDwY4V1AMoNc4+n2fIT6pZJggSAGUw
	sGChtg1g+4jHns5vZ3jFmaW2wZKaLeHt5U5Otzcc4nHeB0csYD4obdoVx0QQ
X-Gm-Gg: AZuq6aI3eVglqVmqjHAa4rqDnWoE8tXgZlu+FwngLpZWkQFpFBAPf2pf8eRPC2zRojG
	6BpJtZXyHAe0z3rK7/AtlKmZLcrtZoeCdmdpPyqsG/S7WyrONZqXKqLSs7XayhkECAqeh/3xXo4
	oud4SO7U451QMjIdhNLX2CBGVJEQRAxXvp/HzbivFWy4QChMZkOKpehA3mudHUyQ7us2U2XxzJO
	5TY7sq8QpSlQcV5+CNIawPdyse/qOliFpY2rskuvU5J6hmYhV7JurGQ/ecl+E2QJ7Dwf8Mgg1Qu
	+k9IplgTKQv+zIDG4vnBUm4UCOHp0CV3WBgtvuoPFD/+ljg0FFU+qDUmS1UkEhO2SKsYMZSpHUI
	wdi/QX6c3caanNCj98rbxuaozELiDJ1QdovQFLTc9sec8L0Jf7WQZy9fjcxPwCM2UUQEIFfLRLf
	JtpVeZ3cJAyGds/nobdozVC6qGj+1yfw8Fr8iiSlFdM0f/Ko7LdcSc0Tj/LguKZdNCVSmoFDQ7e
	b/ET+RQlvKwG2PW+mcZcQ4p0NV2
X-Received: by 2002:a05:693c:2297:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2babc00de20mr294609eec.1.1770963323442;
        Thu, 12 Feb 2026 22:15:23 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dccfe0esm4903464eec.18.2026.02.12.22.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:15:23 -0800 (PST)
From: stfomichev@gmail.com
Date: Thu, 12 Feb 2026 22:15:22 -0800
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Subject: [ANN] bpf development stats for 7.0
Message-ID: <aY7Beg9U_jEg8Iz1@mini-arch>
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
https://lore.kernel.org/netdev/20260212124208.187e53ae@kernel.org/

Previous cycle:
29 Sep to 30 Nov: 5851 mailing list messages, 62 days, 94 messages per day
415 repo commits (7 commits/day, 42.41% of these are selftests)
https://lore.kernel.org/bpf/aTBxuQSvtATrr3mu@mini-arch/

Current cycle:
1 Dec to 8 Feb: 6133 mailing list messages, 69 days, 89 messages per day
205 repo commits (3 commits/day, 44.39% of these are selftests)

Testing
-------

Top contributors of selftests:
   1 [ 15] Bastien Curutchet
   2 [ 12] Alexis Lothoré
   3 [  7] Jakub Sitnicki
   4 [  6] Kumar Kartikeya Dwivedi
   5 [  6] Mykyta Yatsenko
   6 [  5] Hoyeon Lee
   7 [  5] Anton Protopopov
   8 [  4] Puranjay Mohan
   9 [  4] Matt Bobrowski
  10 [  3] Alexei Starovoitov

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [11] Alexei Starovoitov      1 ( +1) [25] Alexei Starovoitov  
   2 ( +1) [ 4] Andrii Nakryiko         2 ( +1) [21] Andrii Nakryiko     
   3 ( -1) [ 3] Eduard Zingerman        3 ( -2) [16] Eduard Zingerman    
   4 ( +1) [ 2] Yonghong Song           4 (   ) [ 6] Jakub Kicinski      
   5 ( -1) [ 2] Jakub Kicinski          5 (+46) [ 6] Aleksandr Loktionov 
   6 (+14) [ 2] Kumar Kartikeya Dwivedi    6 ( +1) [ 5] Yonghong Song       
   7 ( -1) [ 1] Martin KaFai Lau        7 ( -2) [ 4] Martin KaFai Lau    
   8 ( +6) [ 1] Steven Rostedt          8 (+16) [ 4] Harry Yoo           
   9 (+13) [ 1] Toke Høiland-Jørgensen    9 (   ) [ 4] Steven Rostedt      
  10 (   ) [ 1] Paolo Abeni            10 (+20) [ 3] Kumar Kartikeya Dwivedi
  11 ( -2) [ 1] Alan Maguire           11 (***) [ 3] Hao Li              
  12 (+16) [ 1] Menglong Dong          12 (***) [ 3] Matt Bobrowski      
  13 ( +3) [ 1] Ihor Solodrai          13 (***) [ 3] Michael S. Tsirkin  
  14 (+28) [ 1] Mykyta Yatsenko        14 (***) [ 3] Suren Baghdasaryan  
  15 ( +4) [ 1] Amery Hung             15 (***) [ 2] Hari Bathini        

Top authors (cs):                    Top authors (msg):                  
   1 ( +1) [2] Puranjay Mohan           1 ( +8) [17] Menglong Dong       
   2 (+11) [1] Leon Hwang               2 ( +6) [14] Leon Hwang          
   3 (+22) [1] Ihor Solodrai            3 (+14) [13] Puranjay Mohan      
   4 ( +4) [1] Alan Maguire             4 ( +2) [12] Chia-Yu Chang       
   5 (***) [1] Emil Tsalapatis          5 (***) [11] Wei Fang            
   6 ( +6) [1] Mykyta Yatsenko          6 ( +1) [10] Amery Hung          
   7 ( -4) [1] Alexei Starovoitov       7 (+17) [ 9] Jens Remus          
   8 (+12) [1] Matt Bobrowski           8 (+11) [ 9] Ihor Solodrai       
   9 ( -8) [1] Menglong Dong            9 ( -5) [ 9] Mykyta Yatsenko     
  10 ( -6) [1] Jiri Olsa               10 ( +2) [ 7] Daniel Borkmann     

Top scores (positive):               Top scores (negative):              
   1 (   ) [173] Alexei Starovoitov     1 ( +8) [58] Menglong Dong       
   2 ( +1) [ 97] Andrii Nakryiko        2 ( +4) [51] Leon Hwang          
   3 ( -1) [ 69] Eduard Zingerman       3 ( +2) [50] Chia-Yu Chang       
   4 ( +1) [ 35] Jakub Kicinski         4 (+12) [49] Puranjay Mohan      
   5 ( -1) [ 32] Yonghong Song          5 (***) [45] Wei Fang            
   6 (   ) [ 26] Martin KaFai Lau       6 (+12) [37] Jens Remus          
   7 (***) [ 22] Kumar Kartikeya Dwivedi    7 ( +5) [28] Amery Hung          

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):                
   1 (   ) [16] Meta                    1 (   ) [77] Meta                
   2 (   ) [ 4] Intel                   2 ( +2) [17] Google              
   3 (   ) [ 3] RedHat                  3 (   ) [16] Intel               
   4 (   ) [ 3] Google                  4 ( -2) [12] RedHat              
   5 ( +4) [ 2] Linux Foundation        5 (   ) [ 7] Oracle              
   6 (   ) [ 2] Isovalent               6 (   ) [ 3] Isovalent           
   7 ( -2) [ 1] Oracle                  7 (+10) [ 3] Unknown             

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [5] Meta                     1 (   ) [38] Meta                
   2 (   ) [3] Google                   2 ( +4) [19] Tencent             
   3 ( +3) [2] Amazon                   3 (+15) [18] Amazon              
   4 (   ) [1] Isovalent                4 ( -1) [16] Isovalent           
   5 (   ) [1] Oracle                   5 (   ) [14] Google              
   6 ( +9) [1] Shopee                   6 (+10) [14] IBM                 
   7 ( +4) [1] IBM                      7 ( +7) [14] Shopee              

Top scores (positive):               Top scores (negative):              
   1 (   ) [218] Meta                   1 (+12) [68] Amazon              
   2 (   ) [ 73] Intel                  2 ( +6) [63] Tencent             
   3 ( +5) [ 41] RedHat                 3 (+13) [51] IBM                 
   4 ( -1) [ 21] Linux Foundation       4 ( +2) [51] Shopee              
   5 (***) [ 17] Google                 5 (   ) [50] Nokia               
   6 ( -1) [  9] Hedgehog               6 (***) [43] NXP                 
   7 (***) [  6] Loongson               7 ( -5) [36] Isovalent           

More raw stats
--------------

Prev: start: Mon, 29 Sep 2025 10:22:06 +0800
	end: Sun, 30 Nov 2025 21:06:29 +0800
Prev: messages: 5851 days: 62 (94 msg/day)
Prev: direct commits: 415 (7 commits/day)
Prev: test commits: 176 (42.41%)
Prev: people: 289  {'author': 105, 'commenter': 120, 'both': 64, 'none': 19}
Prev: people pct: {'author': 0.341, 'commenter': 0.39, 'both': 0.208, 'none': 0.062}
Prev: review pct: 36.39%  x-corp pct: 26.51%
Prev: avg revisions: single patch: 1.41 patch set: 2.11

Curr: start: Mon, 01 Dec 2025 21:44:16 -0800
	end: Sun, 08 Feb 2026 20:59:08 -0800
Curr: messages: 6133 days: 69 (89 msg/day)
Curr: direct commits: 205 (3 commits/day)
Curr: test commits: 91 (44.39%)
Curr: people: 310  {'author': 122, 'commenter': 132, 'both': 56, 'none': 22}
Curr: people pct: {'author': 0.367, 'commenter': 0.398, 'both': 0.169, 'none': 0.066}
Curr: review pct: 42.44%  x-corp pct: 31.22%
Curr: avg revisions: single patch: 1.44 patch set: 2.57

Diff: -13.5% linux-next size
Diff:  -5.8% ( +8.8%) msg/day
Diff: -55.6% (-48.7%) commits/day
Diff:  -3.6% (+11.4%) people/day
Diff: review pct: +6.0%
      x-corp pct: +4.7%
Diff: avg revisions: single patch: +1.7% patch set: +21.8%

Contributions to selftests: total individuals: 31 (was 46, -32.61%)
Contributions to selftests:
   1 [ 15] Bastien Curutchet
   2 [ 12] Alexis Lothoré
   3 [  7] Jakub Sitnicki
   4 [  6] Kumar Kartikeya Dwivedi
   5 [  6] Mykyta Yatsenko
   6 [  5] Hoyeon Lee
   7 [  5] Anton Protopopov
   8 [  4] Puranjay Mohan
   9 [  4] Matt Bobrowski
  10 [  3] Alexei Starovoitov
