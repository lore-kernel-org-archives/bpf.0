Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E55C0A
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364394; cv=none; b=qNL71Hr1W6qcih/dOd1vgU80yzNDdHebqB8QMigGztsN7RwmTH6b8OpHvJTyvdo2B9LrARI/PntXhhPt9b0Y0cknO+vsS06mjF3lOUUAPO9m4g8pMgbF1y1D9G7dMVtNzehgTDOd8C9OKdaiAgLkhHfGk9zf8f/IiNL7BeTd/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364394; c=relaxed/simple;
	bh=piG2rXxZoNWNLHVe2jt8nXi/uTj0WnUwIhx6oIXRqiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UnHwG8JnBE5k9Kt5vAaqSDkkxXkaMJ7mUeGNaw9lP+bGK8BJf9MKib7hmYOO5wNu0qn+m4fjl9XQEanrYO2wQGsw1Qf+fgO1bmwY8s+/lgDnAWXJmR2l6XLh/jsfMIEt9Nrgac7Z9Et3NnVQxf3rKZr/RJohGkS3it6ah+lLubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gy0uLXjs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gy0uLXjs"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6bab4b84dso367752b3a.0
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710364392; x=1710969192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7ymW/w6FN24g8YRZdKxVTQojlAvJL0x5K9BRhatGis=;
        b=gy0uLXjsCVaWqKT1FEzmF34Idu1DsL7GrwRnv5bWkYvWvQkoHFHUEyui2FdCem0Lkw
         aJk1j+88CQW3injxyKmV9l7rYNfIA/geAP4cU4glR+yb9QwYmT5eDIIZFL0teszjizLm
         OAtmKqTwZd8cRp3D7Vj4WWavqmx2mrxa/AILGij/PRHal0Pk+F7LeCjqamcBAlPAs+1c
         WbJb1hOtwe5tKH3mUDlRgKPskROETlkt8A1iaf7PsrM8FA8vBsi8ELLq0TGiw4KboYHb
         aVyQW01srMHpoQWU1wTHlOgDKhgzFFfZjNrIwst8OG47U5pUO6ICT1CVG5Xsc1i7wtIA
         jpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364392; x=1710969192;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7ymW/w6FN24g8YRZdKxVTQojlAvJL0x5K9BRhatGis=;
        b=haqyeuk4Ta2ydezyR8iuAL0XMDB4ZzRzF4Ui3qPVfqmYx+eDBjPUXb35btJ6DG9iDC
         7bGO+xF9G3BEhlUuXbCDZ1cxxMT/kd8Vv9N1/OJgmbrBkHBE3oVohgqnvo8CmeXS63g0
         rA6bGMtSzzgTsLhZjZ+cFHubNpetvEi2mZKFdLw5kTp7MTYQEkdNgqXYXB7nEqGF0TxO
         8zFHSp26Z5d4y1jmY8GDarqTSndUaolAulEkNb3LdseuOGxWzgd+44qq5LSA3bnT+lQ4
         u6PImksm4I1xLt/7vqTuqsqCt9yH+FWH/hXiehqHan6jrB4eUBaYWeitfDDZ50JbzeZB
         GLRw==
X-Gm-Message-State: AOJu0Yz8J/+K0f5EOBNauEnl3AVga3SM0o7g+QJD+x7K5GISPQpwlFhC
	oO+4rCY04smHz/RGqPgT2SN/0xyP8gmdYO+LH2iHQdFBM44pg4NIcRkrPL2DRnKAD8jqrGe8vQB
	icTgNq+gwZmzQoJbVQKWdSHT/PlX065ClRlqfTAEIfhEMYzOF1vn+nx7F4oYVRCKtaxjAYTZxYG
	bYf7k+EQXilaGr
X-Google-Smtp-Source: AGHT+IElkCQ8oXEWAyf1Mjd+P6pBGxvu9W8jGip/cU2tnBq7HxdCXu0HnP9HaR0PKh5rC/x5BreznoU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1884:b0:6e5:e596:55ae with SMTP id
 x4-20020a056a00188400b006e5e59655aemr226258pfh.1.1710364391669; Wed, 13 Mar
 2024 14:13:11 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:13:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZfIW5n6qBzPITavK@google.com>
Subject: [ANN] bpf development stats for 6.9
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As usual, following up with BPF stats after the netdev posted theirs.
See https://lore.kernel.org/netdev/20240312124346.5aa3b14a@kernel.org/
for more info.

6.8 stats: https://lore.kernel.org/bpf/ZaA6-k5pU5nZJZtI@google.com/

Previous cycle:
27 Oct to 10 Jan: 5795 mailing list messages, 75 days, 77 messages per day
624 repo commits (8 commits/day)

Current cycle:
9 Jan to 11 Mar: 4536 mailing list messages, 62 days, 73 messages per day
602 repo commits (10 commits/day)

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 ( +2) [5] Yonghong Song            1 ( +1) [18] Andrii Nakryiko    =20
   2 (   ) [5] Andrii Nakryiko          2 ( +2) [14] Yonghong Song      =20
   3 ( -2) [5] Alexei Starovoitov       3 ( -2) [12] Alexei Starovoitov =20
   4 ( +1) [3] Jiri Olsa                4 ( -1) [10] Eduard Zingerman   =20
   5 ( +2) [3] Martin KaFai Lau         5 ( +1) [ 8] Martin KaFai Lau   =20
   6 (***) [2] David Vernet             6 (***) [ 8] David Vernet       =20
   7 ( -1) [2] Daniel Borkmann          7 ( -2) [ 5] Jiri Olsa          =20
   8 ( -4) [2] Eduard Zingerman         8 ( +1) [ 4] Daniel Borkmann    =20
   9 (   ) [1] Jakub Kicinski           9 (+25) [ 4] Toke H=C3=B8iland-J=C3=
=B8rgensen
  10 ( -2) [1] John Fastabend          10 (+36) [ 4] Jason Wang         =20
  11 (   ) [1] Song Liu                11 ( +2) [ 3] Jakub Kicinski     =20
  12 (+16) [1] Toke H=C3=B8iland-J=C3=B8rgensen   12 ( -4) [ 3] John Fastab=
end     =20
  13 (+27) [1] Paolo Abeni             13 (+30) [ 3] Kumar Kartikeya Dwived=
i
  14 (+10) [1] Quentin Monnet          14 (+13) [ 3] Christoph Hellwig  =20
  15 ( -5) [1] Stanislav Fomichev      15 ( -5) [ 3] Song Liu           =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [2] Andrii Nakryiko          1 ( +2) [14] Kui-Feng Lee       =20
   2 (+34) [2] Dave Thaler              2 (+10) [14] Xuan Zhuo          =20
   3 (   ) [1] Yonghong Song            3 ( -1) [12] Masami Hiramatsu (Goog=
le)
   4 (***) [1] "Jose E. Marchesi"       4 ( -3) [11] Andrii Nakryiko    =20
   5 (***) [1] Kui-Feng Lee             5 (+22) [11] Alexei Starovoitov =20
   6 ( +7) [1] Alexei Starovoitov       6 ( +3) [ 9] Eduard Zingerman   =20
   7 (***) [1] Puranjay Mohan           7 (+22) [ 8] Ian Rogers         =20
   8 ( -4) [1] Jiri Olsa                8 (***) [ 5] Benjamin Tissoires =20
   9 (***) [1] Toke H=C3=B8iland-J=C3=B8rgensen    9 (+13) [ 4] Jamal Hadi =
Salim   =20
  10 (+24) [1] Ian Rogers              10 ( -2) [ 4] Yafang Shao        =20

Top scores (positive):               Top scores (negative):             =20
   1 ( +3) [78] Yonghong Song           1 ( +5) [54] Xuan Zhuo          =20
   2 (***) [57] Andrii Nakryiko         2 ( -1) [44] Masami Hiramatsu (Goog=
le)
   3 (   ) [48] Martin KaFai Lau        3 ( -1) [44] Kui-Feng Lee       =20
   4 (***) [38] David Vernet            4 (+17) [30] Ian Rogers         =20
   5 ( -4) [35] Alexei Starovoitov      5 (***) [19] Benjamin Tissoires =20
   6 ( -1) [32] Jiri Olsa               6 (***) [13] Matt Bobrowski     =20
   7 ( +2) [30] Daniel Borkmann         7 ( +1) [11] Yafang Shao        =20
   8 ( -1) [21] Jakub Kicinski          8 ( +7) [10] Jamal Hadi Salim   =20
   9 (***) [19] Song Liu                9 (***) [10] Choong Yong Liang  =20
  10 (+24) [17] Christoph Hellwig      10 (***) [10] Alexander Lobakin  =20

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [12] Meta                    1 (   ) [52] Meta               =20
   2 (   ) [ 7] Isovalent               2 ( +5) [15] RedHat             =20
   3 ( +2) [ 4] RedHat                  3 ( -1) [14] Isovalent          =20
   4 (   ) [ 3] Google                  4 (   ) [ 9] Google             =20
   5 ( -2) [ 2] Intel                   5 ( -2) [ 5] Intel              =20
   6 ( +1) [ 1] Huawei                  6 ( +7) [ 4] Oracle             =20
   7 ( +1) [ 1] Oracle                  7 ( -1) [ 4] Huawei             =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [8] Meta                     1 (   ) [52] Meta               =20
   2 ( +1) [3] Google                   2 (   ) [28] Google             =20
   3 (+27) [2] Microsoft                3 ( +3) [14] Alibaba            =20
   4 (+22) [2] Oracle                   4 ( +1) [12] Intel              =20
   5 ( -3) [2] Intel                    5 (+10) [11] RedHat             =20
   6 ( +1) [2] RedHat                   6 ( -2) [ 9] Isovalent          =20
   7 ( -2) [2] Huawei                   7 ( -4) [ 8] Huawei             =20

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [79] Isovalent               1 ( +1) [57] Google             =20
   2 (***) [66] Meta                    2 ( +1) [55] Alibaba            =20
   3 (   ) [29] RedHat                  3 (***) [12] Intel              =20
   4 (***) [17] Unknown                 4 ( +3) [11] Juniper Networks   =20
   5 (   ) [13] Linux Foundation        5 ( +1) [11] Amazon             =20
   6 ( +3) [12] ARM                     6 ( +4) [ 9] Mojatatu           =20
   7 (+48) [11] Oracle                  7 (+15) [ 9] Loongson           =20

More raw stats
--------------

Prev: start: Fri, 27 Oct 2023 13:33:09 -0700
	end: Wed, 10 Jan 2024 14:29:01 -0500
Prev: messages: 5795 days: 75 (77 msg/day)
Prev: direct commits: 624 (8 commits/day)
Prev: people/aliases: 246  {'author': 87, 'commenter': 105, 'both': 54}
Prev: review pct: 33.49%  x-corp pct: 29.97%

Curr: start: Tue, 09 Jan 2024 14:38:27 -0800
	end: Mon, 11 Mar 2024 13:51:49 -0700
Curr: messages: 4536 days: 62 (73 msg/day)
Curr: direct commits: 602 (10 commits/day)
Curr: people/aliases: 249  {'author': 79, 'commenter': 117, 'both': 53}
Curr: review pct: 37.04%  x-corp pct: 31.89%

Diff: -5.3% msg/day
Diff: +16.7% commits/day
Diff: +22.4% people/day
Diff: review pct: +3.5%
      x-corp pct: +1.9%
