Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C832BE620
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895757; cv=none; b=IpavCsX8lbYK6QWsgJ52Vl6AG7J6dfqsXBBxCy4Gj1N29i2asCAAMwc4DPGa9YqYgkTJ1hqGxzF0fZbVSg2JMd9EB9uj7jTDzChpaaCNiOKJzR73MARsdcWAq0CdZ29z5+ffHTUman5VX+SX7m0LzlUhSWlcNH1BVWliNmqJ0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895757; c=relaxed/simple;
	bh=mEYDaQXqOItLMXijvpVCXJ71dE7RCdtN/oESa5gdiB0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZJk6oAJl1TsPIYcShs4db+kh3vmu2u7soZ0f5QJNLkzN5I2uCT7n0Yevbq3wp61K//NP8PUGZlWjCZcPx80E/d8iIPdnQl6HVxpvg95U9r3/Hznc6SQlZAQREuuKBkrYbfMftvkw5k/3g9x+AvNz0DC2KAfbjF1WUOSouAst+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwr1ovX8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwr1ovX8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso73283955e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770895754; x=1771500554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4+cQNSJfzqdjj8LLuiQ+/iayro/Tqs9ALZzQFWVk7o=;
        b=Zwr1ovX84UHGRBrWzJ7NPB/TX6t2Chp7B+eBwxvWUSJ3jx0LF4mUypx+fKdc9+n3j/
         x7pQFtNJwsUh8r5rpEI1XDB0Zbk0xMsLaaFh5OtBQHf2cLjrlhxPeQ1/9Y8lT10MQMpt
         7dciQclqObotHVT1kUqzlbamcZJBIl525ZPbJyH6EYePayCzbmV8oy89N/0V9K3HmbHe
         oC7ecl+mvIMi2DV+72j3us6iXHbov1C6gftQv/TC9dKO5v1wrNBRc6s5J7jcWOx0pRWn
         yqQVSTBZdKuV5NPXXkseWCRMx3XsRUX185P6XkGMlDYxBTtwbKwI0bA5oAWHUaZZv8pz
         ZTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895754; x=1771500554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4+cQNSJfzqdjj8LLuiQ+/iayro/Tqs9ALZzQFWVk7o=;
        b=m4isjEGAaPzYwNmUTYKKf6C4rwSJ7wYGUgPN/IoBFatMJubK2HTWF/uUgd1IYnDGLG
         6pZFClozL1fW1Tl0sKPxmHM8RgslxUX308+0e/RqZ/DLI/pqOWD6DRkO8sifm4yDVf48
         uXiwkNTnqlr3gGRw85r30k9yqNi9TgWO/7WsgFKWPaSgUUbaI8K2QJfctWKBC7GdcntO
         QppZm8JiIp//URPI60abrYoxDfah+fVmIjiRJonKeW3lTRonLwwDys211Ug1/24gWLo7
         Szplme8MM8hAYYWoa7/DRLv6k2BG4RZtk2zPm8doqLmLJkDWYeQvRiqTTgq5zpbBJDkS
         OjHw==
X-Forwarded-Encrypted: i=1; AJvYcCXB0PBCMeZXnUXI0/SRaJd9utFsoMvd802mdCGuiJwY935Qcpk2ZL9P8TmfUYjeIG1yEDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKGT8QnNRzdxcWmrjNh/AACo5AT8fQapH86xI0ezdUQjS0E3V
	VTETeJ9K+AX7gywYx80g+SlD8k+RtF0eIGIVWAkTt6qSDlC99eGH/HDO
X-Gm-Gg: AZuq6aL55/TSzSlW4jVpquC2FbHOBpjk8I1iwWPb34/vQUKQvEl9rKzdDnx1TUT9dXc
	JuhwXvi8vcDskYHjs68oz86zbEguPv3dYFbcmhyqKNkQmY4ehsh+ec+I1AmJCXzTnPgXIHo07XS
	iZcKtUREhYGPuT65p8qea1b8VjzwqG0sj+VTFMo6fvMf7XmQ+ra03MU4zERnjWeJzca8y9w4sgo
	qqy3djnrmzETlD2O1iA/DHhhclCy03YBBOH1St5Nnwyg1a5088QZ2OJurbnIdeHRUpRZwD8cRSI
	KY/U05eSVP9+0sdrYxtwG28A88k+jN+lZnL67C9bSJVkxcgkd/6xU4WBgMzpNDEH/8J39yjNfmX
	XO8KM82arfOZIT6xSILo5CXvgiQ3dlY17zcgmU0qwe6nFZepK42pUk4ORPh1WQO2YmLtSjbli
X-Received: by 2002:a05:600c:4e44:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-4836570e664mr35010795e9.18.1770895754391;
        Thu, 12 Feb 2026 03:29:14 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836cd7af87sm20546075e9.1.2026.02.12.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:29:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 12:29:12 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 09/14] selftests/bpf: Fix double thread join
 in uprobe_multi_test
Message-ID: <aY25iDtg_kBEDyvE@krava>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-10-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212011356.3266753-10-ihor.solodrai@linux.dev>

On Wed, Feb 11, 2026 at 05:13:51PM -0800, Ihor Solodrai wrote:
> ASAN reported a "joining already joined thread" error. The
> release_child() may be called multiple times for the same struct
> child.
> 
> Fix by setting child->thread to 0 after pthread_join.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 2ee17ef1dae2..17881e009eee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -62,8 +62,10 @@ static void release_child(struct child *child)
>  		return;
>  	close(child->go[1]);
>  	close(child->go[0]);
> -	if (child->thread)
> +	if (child->thread) {
>  		pthread_join(child->thread, NULL);
> +		child->thread = 0;
> +	}
>  	close(child->c2p[0]);
>  	close(child->c2p[1]);
>  	if (child->pid > 0)
> -- 
> 2.53.0
> 
> 
