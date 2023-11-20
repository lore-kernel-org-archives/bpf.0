Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neKj4Lc7"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612B9F;
	Mon, 20 Nov 2023 07:41:16 -0800 (PST)
Message-ID: <c36975ce-8dfe-49aa-aa87-e99921f09d2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700494874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxJn8B1AdcizUtsUyNXEb74YKXEtQIzALA/bah9p0Ig=;
	b=neKj4Lc7xEDqZtTVXoS6VALbCSieg9EkpZxKHgBeDflq5VTLbQ+XXRbrUZkUPWuTXsnbYv
	ffaRwSZth/R3xaY3DDUymqL0hr+JniE5CoPDK/idE4f9YzraGzXRETrkS4Z1mOVcZAC67C
	OmXUPPK3+2hpNSMteTDpmMBpuC3qc1I=
Date: Mon, 20 Nov 2023 07:41:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bpf_obj_id
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, andrii.nakryiko@gmail.com, mykolal@fb.com,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB65637AF2A72DAC44AA5642F6E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB65637AF2A72DAC44AA5642F6E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/18/23 1:45 PM, Yuran Pereira wrote:
> bpf_obj_id uses the `CHECK` calls even though the use of
> ASSERT_ series of macros is preferred in the bpf selftests.
>
> This patch replaces all `CHECK` calls for equivalent `ASSERT_`
> macro calls.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

