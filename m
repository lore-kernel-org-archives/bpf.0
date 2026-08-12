Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66070315785;
	Wed, 12 Aug 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540066; cv=none; b=uHOi+PQsBp+tl09y35qGiPxGVr7ckErLKzULfZ+wBKgeKjVeW1UaWQJvUDBj97YtPDojBrWlTumzYjCymlV2qmDJIMU+Z/s1OYH8UFcwZrAGMlk916dXFmq8j/vMaDVc/MwEGzwnqQFE9K3MoGc2cUlCwyAqO/8mbdWKd4ngQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540066; c=relaxed/simple;
	bh=8jV1of6OCDvTJ6rGcL7peMibBQ1Al1d3woY3yewAqpw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B8PPqYyHhzGtlhKzFskl0rbUht28xHXuoNDiBpQs/EDLAll2LQoGop2rO4fa9vLWdSJVFyXwqLan9J1hNEdW6+dJOjhqRSNhawV7Hmck/xWRaMRdzS4tMxwGMle3+w/ZWo3ZX3SMrU8kv4e21tvIGxBmT4iAh07qEDbTdSrCEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgauwko1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgauwko1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA661F000E9;
	Wed, 12 Aug 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786540065;
	bh=8jV1of6OCDvTJ6rGcL7peMibBQ1Al1d3woY3yewAqpw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qgauwko14ZtBrifbiwU9EwbyU0grV9F1ss/R1zJHsldlPk8OsU6boSme+VoUnc+Or
	 xeZM9QeMcQnvEla96TVtZe3Pe88tM1zylVbzKyaG9+9Ard7GWhqy+A24VUZEXnFYUh
	 PSddH9/c9jxBB9P6uivSBc44c1gnxZyYlbJsEJdpW8oDpsrpxs0JGnGNMXre3tNMLu
	 CefhhsaQq+xRDYewC6KU2ter39StP2sKMvIcWD3Qk7qL7oKK1HHFZtMNcaHJ4/Cw6w
	 2hTFeOHkNw3WufPeoBRxe3T9HH90sPyvooLXxA/zVgg4AqloIGQReJxqOZri3TrqOX
	 jf5Oz4rkg+FaQ==
Content-Type: multipart/mixed; boundary="===============0397126666267180240=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1eab9fe487b6cba29d405e83619885945bf1143b42cc556aaf282abd0c5ad46a@mail.kernel.org>
In-Reply-To: <20260812121603.1633270-2-manuelebnerli@mailbox.org>
References: <20260812121603.1633270-2-manuelebnerli@mailbox.org>
Subject: Re: [PATCH 1/5] Docs: changes.rst: rename file and references and  add links
From: bot+bpf-ci@kernel.org
To: manuelebnerli@mailbox.org,corbet@lwn.net,skhan@linuxfoundation.org,federico.vaga@vaga.pv.it,akiyks@gmail.com,danielmaraboo@gmail.com,carlos.bilbao@kernel.org,avadhut.naik@amd.com,alexs@kernel.org,si.yanteng@linux.dev,dzm91@hust.edu.cn,2023002089@link.tyut.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ojeda@kernel.org,boqun@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,daniel.almeida@collabora.com,tamird@kernel.org,acourbot@nvidia.com,work@onurozkan.dev,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: manuelebnerli@mailbox.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,workflows@vger.kernel.org,bpf@vger.kernel.org,rust-for-linux@vger.kernel.org,llvm@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 13:07:42 +0000 (UTC)

--===============0397126666267180240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBUaGUgY3VycmVudCBuYW1lIGRvZXMgbm90IHJlZmxlY3QgdGhlIGNvbnRlbnQgb2YgdGhlIGZp
bGUsIHRoZSBuZXcgbmFtZQo+IGRvZXMgc28uIFdpdGggdGhlIGxpbmtzIGxlZ2FjeSByZWZlcmVu
Y2VzIHNob3VsZCBjb250aW51ZSB0byB3b3JrLgo+Cj4gQ2hhbmdlIG5hbWUgdG8gc29mdHdhcmUt
cmVxdWlyZW1lbnRzLnJzdAo+IENoYW5nZSBuYW1lcyBpbiBEb2MvdHJhbnNsYXRpb25zLyoKPiBB
ZGQgbGluayBEb2MvcHJvY2Vzcy9jaGFuZ2VzLnJzdCB0byBzb2Z0d2FyZS12ZXJzaW9uLnJzdC4K
PiBBZGQgbGluayBEb2MvQ2hhbmdlcyB0byBzb2Z0d2FyZS12ZXJzaW9uLnJzdC4KPiBBZGQgbGlu
a3MgaW4gRG9jL3RyYW5zbGF0aW9ucy8qCj4gQ2hhbmdlIGNoYW5nZXMucnN0IHRvIHNvZnR3YXJl
LXZlcnNpb24ucnN0IGluQ2hhbmdlIGNoYW5nZXMucnN0IHRvIHNvZnR3YXJlLXZlcnNpb24ucnN0
IGluCgpUaGUgY29tbWl0IG1lc3NhZ2UgdXNlcyB0aGUgd3JvbmcgZmlsZW5hbWUgaW4gc2V2ZXJh
bCBwbGFjZXMuIFRoZSBwYXRjaApyZW5hbWVzIHRoZSBkb2N1bWVudCB0byAic29mdHdhcmUtcmVx
dWlyZW1lbnRzLnJzdCIsIGJ1dCB0aGUgbWVzc2FnZSBzYXlzCiJzb2Z0d2FyZS12ZXJzaW9uLnJz
dCIgaGVyZToKCiAgQWRkIGxpbmsgRG9jL3Byb2Nlc3MvY2hhbmdlcy5yc3QgdG8gc29mdHdhcmUt
dmVyc2lvbi5yc3QuCiAgQWRkIGxpbmsgRG9jL0NoYW5nZXMgdG8gc29mdHdhcmUtdmVyc2lvbi5y
c3QuCgpTaG91bGQgdGhlc2Ugc2F5ICJzb2Z0d2FyZS1yZXF1aXJlbWVudHMucnN0IiBpbnN0ZWFk
PwoKVGhlIG1lc3NhZ2UgYWxzbyBoYXMgYSBkdXBsaWNhdGVkIGxpbmUgZnJhZ21lbnQ6CgogIENo
YW5nZSBjaGFuZ2VzLnJzdCB0byBzb2Z0d2FyZS12ZXJzaW9uLnJzdCBpbkNoYW5nZSBjaGFuZ2Vz
LnJzdCB0bwogIHNvZnR3YXJlLXZlcnNpb24ucnN0IGluCgpXYXMgdGhpcyBhIGNvcHktcGFzdGUg
ZXJyb3I/CgpbIC4uLiBdCgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9UVy9hZG1pbi1ndWlkZS9SRUFETUUucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfVFcvYWRtaW4tZ3VpZGUvUkVBRE1FLnJzdAo+IGluZGV4IDRiNzAxY2MyODYwZTYuLmJh
MThhMDE2MzlkMmEgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
VFcvYWRtaW4tZ3VpZGUvUkVBRE1FLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX1RXL2FkbWluLWd1aWRlL1JFQURNRS5yc3QKClsgLi4uIF0KCj4gQEAgLTEwNyw3ICsx
MDcsNyBAQAo+Cj4gICAgIOe3qOitr+WSjOmBi+ihjDYueOWFp+aguOmcgOimgeWQhOeorui7n+S7
tuWMheeahOacgOaWsOeJiOacrOOAguiri+WPg+iAgwo+IC0gICA6cmVmOmBEb2N1bWVudGF0aW9u
L3Byb2Nlc3MvY2hhbmdlcy5yc3QgPGNoYW5nZXM+YAo+ICsgICA6cmVmOmBEb2N1bWVudGF0aW9u
L3Byb2Nlc3Mvc29mdHdhcmUtcmVxdWlyZW1lbnRzLnJzdCA8c29mdHdhcmUtcmVxdWlyZW1lbnRz
LnJzdD5gCj4gICAgIOS+huS6huino+acgOS9jueJiOacrOimgeaxguS7peWPiuWmguS9leWNh+e0
mui7n+S7tuWMheOAguiri+azqOaEj++8jOS9v+eUqOmBjuiIiueJiOacrOeahOmAmeS6m+WMheWP
r+iDveacgwoKRG9lcyB0aGUgbGFiZWwgbmVlZCB0aGUgLnJzdCBleHRlbnNpb24/IFNwaGlueCA6
cmVmOiBsYWJlbHMgYXJlIGlkZW50aWZpZXJzLApub3QgZmlsZW5hbWVzLiBMaW5lIDU4IGFuZCBs
aW5lIDIzMSBpbiB0aGlzIHNhbWUgZmlsZSB1c2UgPHNvZnR3YXJlLXJlcXVpcmVtZW50cz4Kd2l0
aG91dCB0aGUgZXh0ZW5zaW9uLCBhbmQgdGhlIGNvcnJlc3BvbmRpbmcgemhfQ04gZmlsZSBhbHNv
IHVzZXMKPHNvZnR3YXJlLXJlcXVpcmVtZW50cz4uIFRoaXMgcHJvZHVjZXMgInVuZGVmaW5lZCBs
YWJlbDogc29mdHdhcmUtcmVxdWlyZW1lbnRzLnJzdCIKZHVyaW5nIHRoZSBidWlsZC4KClRoZSBz
YW1lIC5yc3QtaW4tbGFiZWwgaXNzdWUgYXBwZWFycyBpbgpEb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy9qYV9KUC9wcm9jZXNzL2hvd3RvLnJzdDoxMDguCgoKLS0tCkFJIHJldmlld2VkIHlvdXIg
cGF0Y2guIFBsZWFzZSBmaXggdGhlIGJ1ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3QgYSBi
dWcuClNlZTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9iL21h
c3Rlci9jaS9jbGF1ZGUvUkVBRE1FLm1kCgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRodWIu
Y29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMzE1OTcyMzExNDg=

--===============0397126666267180240==--
