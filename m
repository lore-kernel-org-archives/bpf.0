Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088142982D
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204979; cv=none; b=P0h2A8ZwnDNUaIanJzJfxSo2bIAQLDy62bQXxXOfDapI7j0fH2Ywj8+UHG7LcOMbR0Ab2636GCSEXb+HwBa0tdh3FnT3fXq0ClHan4q0DrqcCpS6FcGoLSgh13hdeXWJ6SNveBtg1Bb1EEPzWKvlP9fsTg2KXAvOrMXyPyxN7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204979; c=relaxed/simple;
	bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExcjYqqsT0F+p5f+ojVNzQ7Oxga9/+19xvuvRmH/C/UrW81lIh1rUBXrFE1MmZnZufeYq7ImOj6rrMoBX+3Ok71By8GzSEKTZaR4vAIgXtWHJIpkdlxncmAv0zxZZlRGK3WJgKtrZfjdMlGNFl4TefdsE/+OnKF9TUY1fvSHtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6DLQYqB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6DLQYqB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aad8123335so82185ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772204978; x=1772809778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
        b=b6DLQYqB9MlFY+Is/m/HyI3mx5yN0t+0elB9Mzazp/Y3znVzFRfNf0iBx3J6cpeJFC
         OJRU/T+q3EAttj97HqRMb+xsON21iIyRXvCB4bJaAt/U83pE2coE90EiPb9AIf/INEyV
         ZMUYxeqDiJiAA786vci7I0n6ZdC6Mvx+/9tQfW5koz1oO7QLbS4fLBfgBHpOTAvvWIGu
         1ugBH/jQnI9Y9KdTlWmncrtFVmr+QiKN9vFXcM2YlTk2A30if8eORtSM234AoTlmaWCl
         uh0vYfYmHNKzL2EYP81D+WPb1kqYGf8RKWes0fK/DlyXQt8zs85vCF6RMz9Ki9x8eM3f
         nwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204978; x=1772809778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfX2g470dRQCs1s3q3T0iw/zUQuuNWiQgKICrIJTCt4=;
        b=om5OXbx8jhHjsxhUypylEyw2rKE0jZOeSdM+GQgdp6ZBayFoQvqugZRoMZvEkanEQL
         D4UbCdisWg5SwW5Utl3nrlF3myvasTQruWOB4jIZkKLcjyEQvZZ0hdYBTSlNTddqP5T5
         6T04CkKAB9iiYv51hgamGfXrou9hIRybaEOf2/vCuzX+BurVY6W6J9fjerTEl2COPLB1
         BKpYuBkuULFWNVNGOcACu3ajhUjttTsXMOCnnKZlS+aF7CABneQQlEdPB5aTQz+XJKJ4
         EWlG+ADwJEVnZE18IK9wH6y9lM1i6bQF4ohflGHKjiVGP/fsricNoNUlPL80iEy7cqWQ
         EhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnijdiV+Aw3X9b5Gdqz6Xx0USC9R3yZ5iQHptNhTZmPrhPCh0DgmKU0STE8CI1uU39/h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hdmpc9O/BKo1CniAIBPuOpuQlAIYCI6LdCHoLSrB3H+Q9POk
	zoRbTha6l+eSaZ9xBkd/jyjolhaN56p0V3hNHxyGHRnJWXBZwYW5wTmYuLfTukm1EKgP1BRn2Lm
	9xo0Bjg==
X-Gm-Gg: ATEYQzyDgZLlQlQj0i6MZU/nmIPTcej2EzdFFBFTln/fxFTIDCFagRvg1roCTRuEpkI
	fUsduK1xO2jeQ/PInCvI/3FBCcUXnV9UH5fBnMDLO4WEq5hVSCKH3IAJDky50ezcKW+Lguz679R
	Az/kYNzxrDdACUOklbx8jQvx7gPUTLnlwimTdxO/aNIfnX1lZa8H0bX+kAke9FZKtDAgmwEHHj/
	8KforuEisCVBLk55r9bp+XMraRgAAO46RxjGbI7KggR8tVR61K3KCg57LcPXyuCPMl+AUDWYSrH
	zwngdITO7FQGpKlKDEcOMkK4S2XTAhu+DLuG9qsgOVk+ab1oTRaOCZ/FvlxoHClT8jcdw2ayoI+
	LLjzIr2123mC0W229cKoKfiwwxgiumzf1SqNTfjAwC0truOTCgbuchorB4AlYm6YD9LgsHoTU/g
	2EzwuKLIr8xKjG+KqVKmKHfI5Qy+alrUFYOrrQyPFWT1pfaMF376bruR9gYQ==
X-Received: by 2002:a17:902:ec83:b0:299:c368:6b1f with SMTP id d9443c01a7336-2adf77829e3mr5978935ad.18.1772204977547;
        Fri, 27 Feb 2026 07:09:37 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359131aa5afsm5045853a91.0.2026.02.27.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:09:37 -0800 (PST)
Date: Fri, 27 Feb 2026 15:09:32 +0000
From: Jordan Rife <jrife@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, daniel@iogearbox.net, sdf@fomichev.me, 
	netdev@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	yusuke.suzuki@isovalent.com, willemdebruijn.kernel@gmail.com, martin.lau@linux.dev
Subject: Re: [net-next,v1,2/2] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
Message-ID: <mg4c5j3brafehwfbxemda5viihhrtz7x34th5y3mfsme4zpu5q@i74mxbf7iown>
References: <20260224190516.2102048-3-jrife@google.com>
 <20260227033658.2599813-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227033658.2599813-1-kuba@kernel.org>

> Should connect_fd be set to -1 after calling destroy() to prevent the double
> close?

Yep, I'll update this in v2.

Thanks!

Jordan
