Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C940A926
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764357; cv=none; b=bkJbJVh18AVxItCbALsBx1KrLwADampKrhS103m6n1YQJ04Dg1/Oh7G7dwaGku78GSNGbDSvzmf54ZXHfWNRDLEOSuE9Jh75/Nqd6/djWhvoX19PPxRFibew+CLbRt4MTa2njJf7gOSvOdGw4W1G8g31rztdhdTj6RndR7TQHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764357; c=relaxed/simple;
	bh=XHLAN/1ZyPmNKfKxxnn40DYE5eIzz7rT8NpRDjeso+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlGsDcsmqSp32tNIiE20UcV8c1gDSnMWDxMiOfFR4pD2hpe9gux7DGT16G/PEliD4iD10TV5rVjBHuDeXj/BxAcyRL7zN9E/l/0NpAl2Q8CBF1xWTzBqKlyJiLNR0tcz5xU8KRmvol/p11G2V+adfysPLUgatxe0+bCmaX+jWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in/OFjY7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in/OFjY7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49954b88fffso23361085e9.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764354; x=1789369154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9cOmcuQayUUNCvgq+25CsYuokAcgEplB60+U0kvgEU=;
        b=in/OFjY7luWDZpD4TRNp5u+cJxkzmncro99nJPxSNykNj0WqSqxcjjLrdvfq2PqzXq
         eOrdCfiDDGela7WFRyCjzNKu8oSF59Pzju3W1lJ5aWPzHNBExiApzXQhQqr/yOCfjZmT
         Yes/39eHDgX3e5AGxMtbmUHpEkTQiQCHfXB0pXmpC1WfMc4u1a3Phsz+QaJpwhMMoT6O
         gLQqw1dh8RpSGDB6QkCoHr6ZfNbJybMJHeaJu74DO7Npw3+u2Qif5fLLZ6TBO+jj9r5X
         feOi2/aKdr/sKKd/LGzHCdSOrHwlQFZQ//xola/QCit3qZXdLYEf0PQYqjBIl4NPrsLy
         ohkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764354; x=1789369154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9cOmcuQayUUNCvgq+25CsYuokAcgEplB60+U0kvgEU=;
        b=OyNXYqGPpznJPLa49kkvNDlhxcJ/q8QrJt1k8C7A4tLGVb/dSe7fXqiQZyIzRW6HDe
         A18UhHTKEUte0olhwt7MqJeXpGyA/yGZwXiym6dByOsbkipNXlElQ2O+li8aMHIafVvh
         pOQMWxySzmWuK54Fdurx2l5VLTW5I1e4Lpcc4LbEIEswuU4k0ftZ8AGsLyKl8n5MppGn
         v+lJlwFOydM25fRdahwMsThgpOi1bMEf0n8XZEoe9cgEhqbyLzh4764T6HoTghnRyFC8
         Geb52KYWmvHYfE/sLlDbgQ2YBfTfNvPG0FmrHXdqD2D1CPUdT1JJY9Bu/rJbEE4DDCdi
         B5jg==
X-Forwarded-Encrypted: i=1; AKwUvByHv51uv1OY+RDXIgTP9tekL8qHw1tIYbGKem+6gGByQdEoO1rImylVY7PwKnfkbDmMGqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lAej+/3GYJpYHYOSXh4WyXdOFK6swsYrTfqj3iXhs2eI2mTFYk
	qtBnj2zIlFajakoXrQWXvIMfSbYwzGBZfoU634ff2zlsZaMkND47j42fH1VGZPbo77w=
X-Gm-Gg: AYBFou0jXrOXTli93tVdqDEM2IK0t4Ba5jD0cB1v2/vpE+RxRxJRyzaXBsQHQ540SLJ
	0uARbhtUJizZ5gj72Ug8M+H1+d54PcHPnWhBaUCpG+XaClAeJw1tS04VzguSdDNizEkxJ9e2cuJ
	PGtjtO4l21LZjYhl94XjhtjLqoQvcK0qjSIxoef8STwe2j5XBE7AsFHNsukZGjjONVkdM1nShRu
	jnK3cf65u7I54BigGywnS6Vogz4MlP+Kb1EeGetSxSJJkNvATOSF7iUk8VXYp8InihA4M7djwsb
	NLpDj+AQXAs/jnZy2OUXv6xLK1c5i+ta9klgrB+T7Fyw8xYvxNHNeO0fH2WtIrgjV8qBasPDrRB
	HLcuFvSCVONhMsGUpTXtRImDBp3Z19LizDFJIEOt5v82qfR9itzeeRUX5Ph/wLxi9txz7E4hERO
	dXUWFp5lLV0LXwkgYNc49DeTUX6I6rehvLQO6bN9dy/QC9vScybgMrR4NMUFYeKpKaQGxvkO3LT
	w==
X-Received: by 2002:a05:600c:34d5:b0:49c:fc6c:bdfe with SMTP id 5b1f17b1804b1-49cfc6cc085mr168534645e9.21.1788764353895;
        Sun, 06 Sep 2026 23:59:13 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm184723965e9.8.2026.09.06.23.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:59:13 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: akpm@linux-foundation.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v4 0/7] bpf: Add user memory access kfuncs for mm_struct
Date: Mon,  7 Sep 2026 09:58:41 +0300
Message-ID: <20260907065841.4129-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904112643.73448e55f788fb1cdcdd12ef@linux-foundation.org>
References: <20260904112643.73448e55f788fb1cdcdd12ef@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why didn't I get the usual bpfbot review emails for this series?  Is
> this a sign that all was clear?

The main work that I have done in v4 (compared to v3) is to address all
bpfbot comments. My undestanding is that all is clear now.

> I'm surprised that bpf even attempts to support NOMMU.  I expect the
> user/tester population is zero.  Perhaps just disallow this, if it
> saves any effort.

I have just documented that in the cover letter and skipped the test
in the last patch of the series in NOMMU. 
