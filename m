Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF93264E3
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589043; cv=none; b=IyEDKuvnDpG82yFu+ZdFaaRHvxnw4dQzWBEEZvhqCZeQ8pUJjh6IupBImnDIfzUugjw75cZxikv2V6aFBXUzTHKQf+X0T/JBgCLSRo4tjcMDFa+tbX9CezhFXgYnrnsB4lvFDEUGxa64P4oPFVZTXbmdZtG7tX9B8Ry2L7qp6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589043; c=relaxed/simple;
	bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdxfHohi/Tsxoyos6wIg6ZttupVCl1qm89JuSwSk4v0qXjgZIPhrXvI96DCOlTxDm0EO8ZLZLLC7SLP2U3c5XEpGuq8f78sqEKOAk1w42lkJsOIAUOFy+GvsGLFtQnDyIbRRqAD++wo5rXh/8yrVRB0LePJ65SQnBaTGLljM4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATb+PIEk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATb+PIEk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so5574447a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 17:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772589042; x=1773193842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
        b=ATb+PIEk4SyFlfYFxpRGimNr88PSj+A5kWXfnysNg9UspIUtQP/U7lUwdu7C3opzAj
         AWcsaVovzIUFtbYJrJP+4BkcCyY64A/888CgKw9yYFMQtomEXH0j3Z/RGrzo5SnHg0wv
         2Lmucs51Nnmjz3+f9vwDart+PedHiEZ0uwHCQn+/rcYy5fJTjr0oSFT1dsztWNoYpZbn
         SIfdC7vl91lwioRfsgnFhMhY/MtXvFIII017pc2Mo9ftYKeTSQQ2bFqScm+i6qMt2Tu6
         fGQZvAWFJ4wEw5dI/jg9igMD06QsYjLpR8OPaSv8a/Fl+xksWqhy/H+Z0+TYasiuGBQf
         Bong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589042; x=1773193842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
        b=GK5fl1qKr2QYzxbPuWm/3cP1vPtT/G2Tpxq44JdD7j202PSJiVfjNISNXZFyWEwfkL
         imSf2rFHNfeNDlPoQZ4h8HAvSn0BXYLe1Zk4LNTZhYVABnIlr5bRz6ZgNKCLR0rGBeY2
         +s3jfaHn/u996OpdZoPkSoc+t50D/J0e9RIc0ujqndI9gy8xSUEU2vjOmW7OPVCIHhqT
         XZgFzUzh6EuE2FoZs10lckZuxaiCSliUhmkYRCxBEF3Pm9vCfAgdXpGlXYYvmRVJ0QFz
         lXjJxuAZfUuAAKHFQAgsc0smAb6Io3ZJYdg8tHYpyRK89EviLvxSufQdBEhKfGzzQqce
         BAXQ==
X-Gm-Message-State: AOJu0YwoT7A2lJwfl/Hr6hulFEv3J8wP2v0aq2PogFXFgInquJgLVjHd
	0Y172eLepttoKoi7VvIkY5Ywc4DGoKDdW2PqI1U3dJ2nKMktugaTGtK2
X-Gm-Gg: ATEYQzzHcZU1+firDegO/8z7iCRDmtuTdEm6fRQiFO6AnfygpOgJmx2KmsCD390R5x+
	9YWoPzgJRLqB3x0OYjkAs0gIiFNbbM0mrWN1uC9Jg8l2FYevNtJoq95sEUyCu2c2xqiF/PerJTC
	a3yFRMM2DnTAtwEyczL92c78TBhK8jGT9zwZM3HnLpIZaGC334fm66bKcVc2bx8V3kRO1IvQOEu
	B/LGENioiFC9SvO9JzrfsCRIp/0utGkNLp+SIqeCMuk6Z7gbp8c2Vr1uBx/3NOwcrB3IqCSYyfy
	Py2+L8MuE60+P1CljjQtJpox8D0m2OD1AZUOgbP8JM7uZmG9vQFlmifcP33c9oYZPrZ6PMs1qDv
	GRqaHfrCJbowGeX7bqkzdvAf2lFia2sVLJahDWLoMAg6hSVYP8hicqlOfmyA+KzGfPDepYQzUO/
	nTenLGiW7UQE3R/nqui5tIg0wQnE88Bk9QnnxZlrqwoPuoPGXrulWvj//g62jkYgALd1dsY9Iff
	yHRtTJioPKT+VdUw5C1Lu8=
X-Received: by 2002:a17:90b:394b:b0:354:9c20:83e4 with SMTP id 98e67ed59e1d1-359a69c14a8mr389684a91.2.1772589041794;
        Tue, 03 Mar 2026 17:50:41 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599bf8aba4sm3574006a91.0.2026.03.03.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:50:41 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: edumazet@google.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	horms@kernel.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 10:50:32 +0900
Message-Id: <20260304015032.751148-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
References: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please read Documentation/process/maintainer-netdev.rst (about the ~24
> hours delay)
>
> Also, please CC MPTCP maintainers, since this patch could impact MPTCP.

Oops, thank you for the pointer. I will follow the 24+ hours delay if I need to update the patch.
I will also CC MPTCP maintainers later.
