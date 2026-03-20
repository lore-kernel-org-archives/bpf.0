Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0672374172
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022476; cv=none; b=Ax8UNYt/oFTo+7f9ESwC7WtsYT/Eh9OrWc8R0xZqdXl+wN8Y6aQRDi7RZf+4oAyaauqRAyASlAf56Yx8tl+aKYzqiLs/yqJWCnBpdhvsZKMth1K0bpaJDt3K6K+gQuSs07AhzmadWLybVGGyT1NpiEyQ0maB/ug0xuJnl2yop6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022476; c=relaxed/simple;
	bh=VvDq6lbA0+MBNpru3nhz56fcZsBSYOu1Jq1hxe+kZqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HfnMgkQEJtaAFH7pCD/xvtTSRs1MO9a9TBIHDCIzPpXWTo+qG1XjPmmeZo+MrTWkgnvUDMP77mRIRYjJRfqjpOdL81z/wE7E2lBD3ew/ZW9ycg7OBsC8uRuDjRYcTeQ6Ms0k5bFhQcrE48qYtBtpWy7SJ+Hjts9Q7ifAMxFKwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5ZA8cTc; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5ZA8cTc"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0e264d802so41199791eec.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774022474; x=1774627274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMm4wBnmSeubt2uXZ01V3PsbZvesaIurFwFXvpVAv2s=;
        b=p5ZA8cTcBkGTqaSrKbX00Vv7Esrp8U1C7LIgV/4rKgpvLbrNolt39ZWtQ/dHnrwK7i
         /xwY2RqfoBDDx3RMOgI3x1oROAteWPnzPNeqTpwcAOaIiMMAHuDdqItU4FgAkYcHCOzk
         p36i1D8JLQGNlRu7z08GNm1oV2R6MGltjuQ7NZmxL1wniqGD+LckzVog0f0jaQJ+HGeW
         wZ5ULKAT5flTAuQoi3e4T8kSPlx2XQC6E0WvHkTOvK7IfRm5kLhV92CS4vcZEc45CGoD
         5lDd9pBMZYLbdoAuiSnL43BekYoqfHTaI6e6nR/ISouk4dv3ua/n4HDnWXuOs8/vvXp6
         /P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022474; x=1774627274;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMm4wBnmSeubt2uXZ01V3PsbZvesaIurFwFXvpVAv2s=;
        b=Pbfbkrd+WYuBUqnQX0fVY5G1GjudhiETttmeNrV9jqkr508ajw+psdirGj7TEPJbiZ
         ZWERHdTx2DC/ZQRST4aYruZzrk99kz+R7rZJX5hjdmvbqiEMo1KZpjFpG77KBff6aDXe
         FEo7FQbv5SEDAOBbiayoMxAyjSiWitgGZH9ObJbvm/k3UBn0+b8q2F+1h4IJIECPwiR7
         Gp6Cx4fVGCstL8ZfhTgVFpDV/X75xmjo4JxmYGp2sqpt4zE7ej2T/2LF7xvFY7hE2ett
         yyTHQjbYNUQkccDBEmrLKVc73NpD2ff0rd6Yw+rwlrWI0KdIWDTqHozRCi/SLiyqWSMZ
         7Fuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqHYTWIJGiKHyi5kW8+GLLjZ1A+QT+aeCbfnlvhBML/I2n7R/mBJsvbYNMexXV7NOE1T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51mJIHu1ONQkh86RWGopLj44vAq8I5tQqMGiyIv6rqAdrgiV8
	zBbV/EUjlQnr2KWCQxI6Y4r5MSyZwxsn4Dvo81Dq+7PyLhVOVN1fjsvl8yAZtXTMUamP8z5K/se
	1943lb/4GkYFrcg==
X-Received: from dybia20.prod.google.com ([2002:a05:7301:314:b0:2c0:f494:8a43])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:9f0c:b0:2b8:4c95:365d with SMTP id 5a478bee46e88-2c1095f54afmr1848097eec.10.1774022473627;
 Fri, 20 Mar 2026 09:01:13 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:00:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320160055.4114055-1-wusamuel@google.com>
Subject: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: andrii@kernel.org, memxor@gmail.com, bpf@vger.kernel.org, 
	Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset adds requisite kfuncs for BPF programs to safely traverse
wakeup_sources, and puts a config flag around the sysfs interface.

Currently, a traversal of wakeup sources require going through
/sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
wakeup source also having multiple attributes. debugfs is unstable and
insecure.

Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
traverse the wakeup sources list. The head address of wakeup_sources can
safely be resolved through BPF helper functions or variable attributes.

On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
speedup (sampled 75 times in table below). For a device under load, the
speedup is greater.
+-------+----+----------+----------+
|       | n  | AVG (ms) | STD (ms) |
+-------+----+----------+----------+
| sysfs | 75 | 44.9     | 12.6     |
+-------+----+----------+----------+
| BPF   | 75 | 1.3      | 0.7      |
+-------+----+----------+----------+

On the memory side, between kernfs, dentry, and kmalloc, each wakeup source
removed from sysfs saves at least 10kB.

The initial attempts for BPF traversal of wakeup_sources was with BPF
iterators [1]. However, BPF already allows for traversing of a simple list
with bpf_for(), and this current patchset has the added benefit of being
~2-3x more performant than BPF iterators.

[1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/

Samuel Wu (2):
  PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
  PM: Add config flag to gate sysfs wakeup_sources

 drivers/base/power/Makefile |  3 +-
 drivers/base/power/power.h  | 14 +++++++++
 drivers/base/power/wakeup.c | 63 +++++++++++++++++++++++++++++++++++--
 kernel/power/Kconfig        | 13 ++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

