Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AD3ACA7C
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354164; cv=none; b=VkPMMCmGyEsxwOBQm18XqYm/ZX0Bq+grre0H06/hYlXi0AltLUxPT+ab5jsVR8DFmG1HxTeFG3jXbcxM3qqkhPjADTE2gp0AZ7/9yBI+Np3HKjTFpw5ME8OJfPd8tX0kG5RSPKashPplSqAqOA614askosI91OeF9fJHUlzPsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354164; c=relaxed/simple;
	bh=w0kI+yFaBlcwHaJPCo0Km4fr+pVeLkd/bQbWcZfiTJo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B39LKPdWTSIUEzTT9oGfezG0FkOGuIaUI1CU/A2aTk8ddTBo9Dpw5hb523q9WXEgyLS/o6x2wHoWcqsqaFI0BTAWehwYd7bFOHPGBRVg6KIOvYS8Fha5/4t9FJPSfRFWYECa5AD5khLKCo8Sd5K2/0e1GnoOfDazKhoi+MKMyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7KJ8Qfg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7KJ8Qfg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f28e0ac23so418080b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354163; x=1776958963; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0kI+yFaBlcwHaJPCo0Km4fr+pVeLkd/bQbWcZfiTJo=;
        b=l7KJ8QfgAeY7H7XZVu7rZBQSI1F8yqlOzJNv58+mbWga2sN9SomGP+65Dc7N/3VQu1
         OUGPn5MMvUl+fFxFRXa9j5/kvztBJiQGk7JxCboYn2QBzah5KBRxoSiqyi2yCty5wzuj
         6qcpjrAeb3szWixtpRRQsXsXL+LDHRNi6UR2/TCrmMbMEydlgSq1PITsE2JAa5xnZqOO
         fB8BSoSPnW2CAFEvgyK7wGvhVcusvUfAy9eEoiG9Ugb5gOlsNyqnb7OKM2hFP8c5SlB+
         KrQPFPZKs+DNT2SNzwHn275eSZ5KN/4TigUe+Hqtb05Xc+sKDPdF/qwLLLgUHxKwrid7
         dhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354163; x=1776958963;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0kI+yFaBlcwHaJPCo0Km4fr+pVeLkd/bQbWcZfiTJo=;
        b=bNee9VeIB8dJZg3d0UkGNoeQPGhH/elHTOzsYZxdVvT7Hwn2Ky+OjGWTdf1Q+RgDOw
         +D9seOtYE7LgwzZTVv+y+UeMssdXTkpUWgTYtIaXkcEgiXajGiDhhRscSgfZnAvgR5zL
         lwsFpkhmAGLiIPX4RSkXQqy7SuAvCyxBKi8b7WH8tgsZmdUF+Kx4gtVubCW4AdQeIRFa
         M32xjXp5Yjii3N4UXEyWMRdURM4ro+y69BX1r+eCNQiyvZwpg5JFRFB5FHmZii45jcG1
         NclaHbzZEr4OrNyFnchckbHGZ7N9P4+5l2GOdWn7hF7UK6+Zt175GkfDQHUa3f/5Yis6
         /yQw==
X-Forwarded-Encrypted: i=1; AFNElJ/lDpx5LB/vDmYvZw2MyAIXJl/SPr+aMBy2KisqOymtozVVI6I7vnmGvkZIJo+MmrFKIps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8S3FXtG/4Es9xoNdLGblz1AeRCgcpyh2DWBj3iG4MkRi0KYB
	ql7CaUgjocQjhJpqsf9vHol7X7BJFhCMj9Wu7Y54pni+mk0EPmjhaW9R//29jg==
X-Gm-Gg: AeBDiesIjxmW2lYo9DQBlaQx6pasbNTUmEU9sUnkaR3iWxJJiiZpyPqIj1A4h01F4en
	mZFGikkaTwXK+8yZgY3GCH3C38sQqtkQMjrpPFbjxierpQ+Qy/qJieeq7PFJbQPeKdFotrceQ9l
	JwagzOkb8yizGRjd2Z5t04fN+PGUVnfG2yMqdXq7OExHzdSuXQrhA+IzyTzy43XfxDQ3GpdgI7P
	MwvmQR84bQsC2KzND0qDjzHLHsOmVuugYNjRYdKQvXSBsv/KalGFoWADwcNSoS1wWUukTTJwKfq
	xxMwolzV6ubCN9Ydn5gwW3aIpEyPlYHihLRpitOeO6ih9Iy6y51sL0qbgE05bX6k6ux1forAOlB
	ppFI2A5yInLT4SPOFn+Ag1hlr8717ZGU6S88hqjrKig0fz5sZKzIy0GNCTyxDIT4Yys7dWRojKa
	wo2ZdCDAxQiiOz+Qj58s8a0TMyjLNmWPupcjGIhHDszNX76+NvNt17HkFacn18VO32Can0AqyrT
	8g7NdNq7PmdLZaAmVedY2J/OV85x145ZPER5ZQc97DYdsA4aCNqLrGd
X-Received: by 2002:a05:6a00:a113:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-82f7edfdeecmr2276339b3a.13.1776354162871;
        Thu, 16 Apr 2026 08:42:42 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67292f77sm6460655b3a.26.2026.04.16.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 08:42:40 -0700
Message-Id: <DHUOZVP8JZ80.28GPGA99P0ORD@gmail.com>
Cc: <john.fastabend@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: reject ERR_PTR map->record in map_check_btf
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sun Jian" <sun.jian.kdev@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260416144808.149543-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260416144808.149543-1-sun.jian.kdev@gmail.com>

On Thu Apr 16, 2026 at 7:48 AM PDT, Sun Jian wrote:
> btf_parse_fields() returns an ERR_PTR() when it encounters an invalid
> special field in map value BTF.
>
> For example, an invalid kptr-annotated field whose tagged pointee is not
> a full struct type can make btf_parse_fields() fail with -EINVAL.
>
> map_check_btf() stores the result in map->record, but currently only
> handles the successful non-NULL case explicitly. ERR_PTR() results are
> not rejected immediately before proceeding with the rest of map BTF
> setup.

yes. So ?

> Handle IS_ERR(map->record) explicitly in map_check_btf() and return the
> underlying error code immediately.

why ?

pw-bot: cr
